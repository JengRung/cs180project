import 'dart:async' show Future;
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:flutterapp/models/anime.dart';

//get response from anime.json data
Future<String> _loadAnimeAsset() async {
  return await rootBundle.loadString('dataset/anime.json');
}

//create AnimeList from anime.json
Future<AnimeList> loadAnimes() async {
  String jsonAnime = await _loadAnimeAsset();
  final response = json.decode(jsonAnime);
  AnimeList animeList = AnimeList.fromJson(response);
  print("animes" + animeList.animes[0].name);
  return animeList;
}

Future<AnimeList> loadAnimeList() async {
  String jsonAnime = await _loadAnimeAsset();
  final response = json.decode(jsonAnime) as List;
  AnimeList animeList = AnimeList(animes: []);
  int i = 0;
  response.forEach((element) {
    animeList.animes.add(Anime.fromJson(element));

    if (i < 10) {
      print(animeList.animes[i].name);
      i++;
    }
  });

  return animeList;
}
