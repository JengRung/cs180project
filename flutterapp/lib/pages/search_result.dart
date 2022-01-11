import 'package:flutter/material.dart';
import 'package:flutterapp/pages/all.dart';
import 'package:flutterapp/components/all.dart';
import 'package:flutterapp/colors.dart';
//import 'package:flutterapp/models/anime.dart';
import 'package:flutterapp/models/all.dart';

class SearchResultPage extends StatefulWidget {
  static String id = 'search_result_page';
  //final Anime? passedAnime;
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  //String animeName = widget.passedAnime.name;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SearchResultsArguments;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  Text('Name: ${args.anime.name}'),
                  Text('Japanese Name: ${args.anime.japaneseName}'),
                  Text('Score : ${args.anime.score}'),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: args.anime.genres.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        width: 500,
                        color: spiritedAwayGreen,
                        child: Center(
                          child: Text('${args.anime.genres[index]}'),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                  Text('Type: ${args.anime.type}'),
                  //Episodes
                  Text('Episodes: ${args.anime.episodes.length}'),
                  Text('Aired: ${args.anime.aired}'),
                  Text('Premiered: ${args.anime.premiered}'),
                  //Producers
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: args.anime.producers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        width: 500,
                        color: spiritedAwayDarkBlue,
                        child: Center(
                          child: Text('${args.anime.producers[index]}'),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                  //Licensors
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: args.anime.licensors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        width: 500,
                        color: spiritedAwayGreen,
                        child: Center(
                          child: Text('${args.anime.licensors[index]}'),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                  //Studios
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: args.anime.studios.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        width: 500,
                        color: spiritedAwayPink,
                        child: Center(
                          child: Text('${args.anime.studios[index]}'),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                  Text('Source: ${args.anime.source}'),
                  Text('Durationg: ${args.anime.duration}'),
                  Text('Rating: ${args.anime.rating}'),
                  Text('Popularity: ${args.anime.popularity}'),
                  Text('Members: ${args.anime.members}'),
                  Text('Favorites: ${args.anime.favorites}'),
                  Text('Watching: ${args.anime.watching}'),
                  Text('Completed: ${args.anime.completed}'),
                  Text('On-Hold: ${args.anime.onHold}'),
                  Text('Dropped: ${args.anime.dropped}'),
                  Text('Plan to Watch: ${args.anime.planToWatch}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
