import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterapp/colors.dart';
import 'package:flutterapp/models/all.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp/env.dart';
import 'dart:convert';

class BarGraph extends StatefulWidget {
  const BarGraph({Key? key}) : super(key: key);

  @override
  _BarGraphState createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  List<String> genreList = [
    'Action',
    'Adventure',
    'Comedy',
    'Drama',
    'Fantasy',
    'Girls Love',
    'Gourmet',
    'Horror',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Slice of Life',
    'Sports',
    'Supernatural',
    'Cars',
    'Demons',
    'Game',
    'Harem',
    'Historical',
    'Martial Arts',
    'Mecha',
    'Military',
    'Music',
    'Parody',
    'Police',
    'Psychological',
    'Samurai',
    'School',
    'Space',
    'Super Power',
    'Vampire',
    'Josei',
    'Kids',
    'Seinen',
    'Shoujo',
    'Shounen'
  ];

  late Future<List<BarChartGroupData>> barChartGroupData;
  int touchedIndex = -1;

  Future<Map<String, double>> getAverageDurations(
      List<String> genres, int n) async {
    Map<String, double> genreDurationMap = {};
    for (int i = 0; i < genreList.length; i++) {
      final response = await http.get(Uri.parse(
          '${Env.URL_PREFIX}/api/averageDuration/?value=${genres[i]}&n=${n.toString()}'));
      final avg_duration = json.decode(response.body);
      genreDurationMap['${genres[i]}'] = avg_duration;
      //print('${genres[i]} =  ${avg_duration}');
    }
    return genreDurationMap;
  }

  Future<List<BarChartGroupData>> getBarChartData(
      List<String> genres, int n) async {
    List<BarChartGroupData> groupData = [];
    int i = 0;
    Map<String, double> genreDurationMap = await getAverageDurations(genres, n);
    genreDurationMap.forEach((key, value) {
      groupData.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(y: value, width: 20.0, colors: [
              spiritedAwayDarkBlue,
              spiritedAwayGreen,
              spiritedAwayPink
            ]),
          ],
          barsSpace: 25.0,
        ),
      );
      i++;
    });
    return groupData;
  }

  Widget makeScrollable(Widget w,
      {double width = 2000.0, double height = 2000.0}) {
    return Scrollbar(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
                width: width,
                height: height,
                child: ListView(
                  children: [
                    SizedBox(
                      width: width,
                      height: height,
                      child: w,
                    )
                  ],
                ))));
  }

  @override
  void initState() {
    super.initState();
    //getAverageDurations(genreList, 10);
    barChartGroupData = getBarChartData(genreList, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Average duration for the top 10 anime from all genres:',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NotoSansJP',
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 25.0),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.width / 4,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder<List<BarChartGroupData>>(
              future: barChartGroupData,
              builder: (BuildContext context,
                  AsyncSnapshot<List<BarChartGroupData>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return BarChart(
                  BarChartData(
                    gridData: FlGridData(show: false),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.white,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              group.x.toString(),
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w300,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${genreList[group.x.toInt()].toString()} \n avg duration \n ${(rod.y - 1).toString()} min',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'NotoSansJP',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          }),
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              barTouchResponse == null ||
                              barTouchResponse.spot == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex =
                              barTouchResponse.spot!.touchedBarGroupIndex;
                        });
                      },
                    ),
                    //maxY: 500,
                    borderData: FlBorderData(show: false),
                    groupsSpace: 30,
                    barGroups: snapshot.data,
                    alignment: BarChartAlignment.center,
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(showTitles: false),
                      rightTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w300,
                        ),
                        margin: 16,
                        getTitles: (value) {
                          return genreList[(value.toInt())];
                        },
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
