import 'package:flutter/src/widgets/framework.dart';

class Anime {
  // final int malID;
  final String name;
  final String score; //double value
  final List<dynamic> genres;
  final String englishName;
  final String japaneseName;
  final String type;
  final List<String> episodes;
  final String aired;
  final String premiered;

  final List<dynamic> producers;
  final List<dynamic> licensors;
  final List<dynamic> studios;

  final String source;
  final String duration;
  final String rating;

  final String ranked;
  final String popularity;
  final String members;
  final String favorites;

  final String watching;
  final String completed;
  final String onHold;
  final String dropped;
  final String planToWatch;

  const Anime({
    required this.name,
    required this.score,
    required this.genres,
    required this.englishName,
    required this.japaneseName,
    required this.type,
    required this.episodes,
    required this.aired,
    required this.premiered,
    required this.producers,
    required this.licensors,
    required this.studios,
    required this.source,
    required this.duration,
    required this.rating,
    required this.ranked,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.watching,
    required this.completed,
    required this.onHold,
    required this.dropped,
    required this.planToWatch,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      name: json['Name'] as String,
      score: json['Score'] as String,
      genres: json['Genres'] as List<dynamic>,
      englishName: json['English name'] as String,
      japaneseName: json['Japanese name'] as String,
      type: json['Type'] as String,
      episodes: ['Episodes'] as List<String>,
      aired: json['Aired'] as String,
      premiered: json['Premiered'] as String,
      producers: json['Producers'] as List<dynamic>,
      licensors: json['Licensors'] as List<dynamic>,
      studios: json['Studios'] as List<dynamic>,
      source: json['Source'] as String,
      duration: json['Duration'] as String,
      rating: json['Rating'] as String,
      ranked: json['Ranked'] as String,
      popularity: json['Popularity'] as String,
      members: json['Members'] as String,
      favorites: json['Favorites'] as String,
      watching: json['Watching'] as String,
      completed: json['Completed'] as String,
      onHold: json['On-Hold'] as String,
      dropped: json['Dropped'] as String,
      planToWatch: json['Plan to Watch'] as String,
      //need to add score-10 - score-1
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Score': score,
        'Genres': genres,
        'English name': englishName,
        'Japanese name': japaneseName,
        'Type': type,
        'Episodes': episodes,
        'Aired': aired,
        'Premiered': premiered,
        'Producers': producers,
        'Licensors': licensors,
        'Studios': studios,
        'Source': source,
        'Duration': duration,
        'Rating': rating,
        'Ranked': ranked,
        'Popularity': popularity,
        'Members': members,
        'Favorites': favorites,
        'Watching': watching,
        'Completed': completed,
        'On-Hold': onHold,
        'Dropped': dropped,
        'Plan to Watch': planToWatch,
      };
}

class AnimeList {
  final List<Anime> animes;

  AnimeList({
    required this.animes,
  });

  factory AnimeList.fromJson(List<dynamic> parsedJson) {
    List<Anime> animes = [];

    animes = parsedJson.map((i) => Anime.fromJson(i)).toList();

    return AnimeList(animes: animes);
  }
}
