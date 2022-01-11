import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';
import 'package:flutterapp/models/all.dart';

class LazyTablePage extends StatefulWidget {
  static String id = 'lazy_page';

  const LazyTablePage({Key? key}) : super(key: key);

  @override
  _LazyTablePageState createState() => _LazyTablePageState();
}

class _LazyTablePageState extends State<LazyTablePage> {
  List<String> animeInfo = [
    'name',
    'score',
    'genres',
    'english name',
    'japanese name',
    'type',
    'episodes',
    'aired',
    'premiered',
    'producers',
    'licensors',
    'studios',
    'source',
    'duration',
    'rating',
    'ranked',
    'popularity',
    'members',
    'favorites',
    'watching',
    'completed',
    'onHold',
    'dropped',
    'planToWatch',
    // 'score-10',
    // 'score-9',
    // 'score-8',
    // 'score-7',
    // 'score-6',
    // 'score-5',
    // 'score-4',
    // 'score-3',
    // 'score-2',
    // 'score-1'
  ];
  Text cellData(int index, Anime anime) {
    String data = '';
    switch (index) {
      case 0:
        data = anime.name;
        break;
      case 1:
        data = anime.score;
        break;
      case 2:
        data = anime.genres.toString();
        break;
      case 3:
        data = anime.englishName;
        break;
      case 4:
        data = anime.japaneseName;
        break;
      case 5:
        data = anime.type;
        break;
      case 6:
        data = anime.episodes.toString();
        break;
      case 7:
        data = anime.aired;
        break;
      case 8:
        data = anime.premiered;
        break;
      case 9:
        data = anime.producers.toString();
        break;
      case 10:
        data = anime.licensors.toString();
        break;
      case 11:
        data = anime.studios.toString();
        break;
      case 12:
        data = anime.source;
        break;
      case 13:
        data = anime.duration;
        break;
      case 14:
        data = anime.rating;
        break;
      case 15:
        data = anime.ranked;
        break;
      case 16:
        data = anime.popularity;
        break;
      case 17:
        data = anime.members;
        break;
      case 18:
        data = anime.favorites;
        break;
      case 19:
        data = anime.watching;
        break;
      case 20:
        data = anime.completed;
        break;
      case 21:
        data = anime.onHold;
        break;
      case 22:
        data = anime.dropped;
        break;
      case 23:
        data = anime.planToWatch;
        break;
    }
    return Text(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ListSearchResultsArguments;
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
          Expanded(
            child: LazyDataTable(
              tableDimensions:
                  LazyDataTableDimensions(cellHeight: 50, cellWidth: 100),
              columns: animeInfo.length,
              rows: args.animes!.animes.length,
              topLeftCornerWidget: Center(child: Text('X')),
              topHeaderBuilder: (i) => Center(child: Text("${animeInfo[i]}")),
              leftHeaderBuilder: (i) => Center(child: Text("Rank: ${i + 1}")),
              dataCellBuilder: (i, j) => Center(
                child: cellData(j, args.animes!.animes[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
