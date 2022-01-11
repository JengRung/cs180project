import 'package:flutter/material.dart';
import 'package:flutterapp/components/gallery_card.dart';
import 'package:flutterapp/components/nav_bar.dart';
import 'package:flutterapp/env.dart';
import 'package:flutterapp/pages/all.dart';
import 'package:flutterapp/components/all.dart';
import 'package:flutterapp/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

final List<dynamic> carouselList = [1, 2, 3, 4, 5];

class HomePage extends StatefulWidget {
  static String id = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'アニメデータ',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'NotoSansJP',
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ModifyPage.id);
                    },
                    icon: const Icon(Icons.edit_outlined)),
                const Text(
                  'Modify',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: ListView(
          //scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            //const NavBar(),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          '../assets/images/coverArt_fate_stay_night.jpeg'),
                    ),
                    color: Colors.black,
                  ),
                ),
                const SearchBar(),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset.fromDirection(50),
                    blurRadius: 30.0,
                    spreadRadius: 60.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: const [
                    OrderedGallery(func: 'filter_score_by_genre'),
                    //feature 2
                    OrderedGallery(func: 'filter_score_by_type'),
                    //feature 4
                    OrderedGallery(func: 'completionRate'),
                    //feature 5
                    OrderedGallery(func: 'topAnimeByStudio'),
                    //feature 6
                    OrderedGallery(func: 'topAnimeByType'),
                    //feature 7
                    OrderedGallery(func: 'topAnimeByRating'),
                    //feature 3
                    BarGraph(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
