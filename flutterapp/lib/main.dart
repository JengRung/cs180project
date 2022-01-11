import 'package:flutter/material.dart';
import 'package:flutterapp/pages/all.dart';
import 'package:flutterapp/pages/lazy_table.dart';
import 'package:flutterapp/pages/list_search_result.dart';

void main() => runApp(const AnimeSite());

class AnimeSite extends StatelessWidget {
  const AnimeSite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => const HomePage(),
          SearchResultPage.id: (context) => const SearchResultPage(),
          ListSearchResultPage.id: (context) => const ListSearchResultPage(),
          LazyTablePage.id: (context) => const LazyTablePage(),
          ModifyPage.id: (context) => const ModifyPage(),
        });
  }
}
