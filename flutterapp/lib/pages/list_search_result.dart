import 'package:flutter/material.dart';
import 'package:flutterapp/models/all.dart';
import 'package:flutterapp/colors.dart';

class ListSearchResultPage extends StatefulWidget {
  static String id = 'list_search_result_page';
  const ListSearchResultPage({Key? key}) : super(key: key);

  @override
  _ListSearchResultPageState createState() => _ListSearchResultPageState();
}

class _ListSearchResultPageState extends State<ListSearchResultPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ListSearchResultsArguments;
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
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: args.animes!.animes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        width: 500,
                        color: spiritedAwayGreen,
                        child: Center(
                          child: Text(args.animes!.animes[index].name),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
