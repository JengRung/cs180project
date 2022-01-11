import 'package:flutter/material.dart';
import 'package:flutterapp/colors.dart';
import 'package:flutterapp/components/gallery_card.dart';
import 'package:flutterapp/models/all.dart';
import 'package:flutterapp/env.dart';
import 'package:flutterapp/pages/lazy_table.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderedGallery extends StatefulWidget {
  final String func;
  const OrderedGallery({
    Key? key,
    required this.func,
  }) : super(key: key);

  @override
  _OrderedGalleryState createState() => _OrderedGalleryState();
}

class _OrderedGalleryState extends State<OrderedGallery> {
  late Future<AnimeList> _topAnimeList;
  late String input;
  late String title;
  late List<String> searchOptions;
  late String dropdownValue;
  late String func;

  Future<AnimeList> getTopPopularAnimeListBy(String func, String input) async {
    final response = await http.get(
      Uri.parse('${Env.URL_PREFIX}/api/${func}?value=${input}&n=100'),
    );
    final items = json.decode(response.body);
    AnimeList animes = AnimeList.fromJson(items);

    return animes;
  }

//implement feature 3 separately (bargraph)
  void setInputType(String func) {
    switch (func) {
      case 'filter_score_by_genre': //feature 1
        input = animeGenres[0];
        searchOptions = animeGenres;
        title = 'Top 100 Most Popular Anime in Genre: ';
        break;
      case 'filter_score_by_type': //feature 2
        input = animeTypes[0];
        searchOptions = animeTypes;
        title = 'Top 100 Most Popular Anime of Type: ';
        break;
      case 'completionRate': //feature 4
        input = animeGenres[0];
        searchOptions = animeGenres;
        title = 'Top 100 Anime with Highest Completion in Genre: ';
        break;
      case 'topAnimeByStudio': //feature 5
        input = animeStudios[0];
        searchOptions = animeStudios;
        title = 'Top 100 Highest Average Scoring Anime from Studio:';
        break;
      case 'topAnimeByType': //feature 6
        input = animeTypes[0];
        searchOptions = animeTypes;
        title = 'Top 100 Highest Average Scoring Anime of Type: ';
        break;
      case 'topAnimeByRating': //feature 7
        input = animeRatings[0];
        searchOptions = animeRatings;
        title = 'Top 100 Anime Rated: ';
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    //set defaults
    setInputType(widget.func);
    dropdownValue = input;
    _topAnimeList = getTopPopularAnimeListBy(widget.func, input);
    func = widget.func;
    print(_topAnimeList);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSansJP',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButton<String>(
                dropdownColor: spiritedAwayPink,
                value: dropdownValue,
                icon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                ),
                iconSize: 24,
                elevation: 10,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    //input = newValue;
                    _topAnimeList =
                        getTopPopularAnimeListBy(func, dropdownValue);
                  });
                },
                items:
                    searchOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(
                      value,
                    ),
                    value: value,
                  );
                }).toList(),
              ),
              IconButton(
                onPressed: () {
                  setState(() async {
                    Navigator.pushNamed(
                      context,
                      LazyTablePage.id,
                      arguments: ListSearchResultsArguments(
                          animes: await _topAnimeList),
                    );
                  });
                },
                icon: Icon(
                  Icons.table_view_sharp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<AnimeList>(
                future:
                    _topAnimeList, //getTopPopularAnimeListBy('genre', 'Horror'),
                builder:
                    (BuildContext context, AsyncSnapshot<AnimeList> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      print('Loading...');
                      return const CircularProgressIndicator();

                    case ConnectionState.active:
                      print('Active');
                      break;
                    case ConnectionState.none:
                      print('No connection');
                      return const CircularProgressIndicator();
                    default:
                      if (snapshot.hasError) {
                        print(
                            'Error: ${snapshot.error}'); //${snapshot.data!.animes[0].name}');
                      } else {
                        print('Result: ${snapshot.data!.animes.length}');
                        if (snapshot.data!.animes.isNotEmpty) {
                          return ListView.builder(
                              padding: const EdgeInsets.all(10.0),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.animes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'NotoSansJP',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 150,
                                          ),
                                        ),
                                      ),
                                      GalleryCard(
                                          anime: snapshot.data!.animes[index]),
                                    ],
                                  ),
                                );
                              });
                        }
                        //print('${snapshot.data!.animes[0].name}');
                      } //${snapshot.data!.animes[0].name}');
                  }
                  return const CircularProgressIndicator();
                }),
          ),
        ],
      ),
    );
  }
}
