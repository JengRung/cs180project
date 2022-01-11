import 'dart:convert';
//import 'dart:html' as VoidCallBack;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/colors.dart';
import 'package:flutterapp/pages/all.dart';
import 'package:flutterapp/services/search_services.dart';
import 'package:flutterapp/models/all.dart';
import 'package:flutterapp/env.dart';
import 'package:http/http.dart' as http;

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _controller;
  late Future<AnimeList> _animeList;
  late Future<Anime> selectedAnime;
  late Anime searchedAnime;
  late AnimeList searchedList;
  final List<String> _animeNames = [];

  final animeKey = GlobalKey<_SearchBarState>();

  final List<String> _searchBy = ['name', 'genre', 'studio', 'score'];
  String dropdownValue = 'name';
  String searchByValue = 'name';

  bool isLoading = true;
  bool isDone = false;
  bool hasData = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _animeList = loadAnimeList();
    getSearchData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getSearchData() {
    _animeList
        .then((value) => setState(() {
              for (int i = 0; i < value.animes.length; i++) {
                _animeNames.add(value.animes[i].name);
              }
              isLoading = false;
              isDone = true;
              hasData = true;
              hasError = false;
            }))
        .catchError((error) {
      for (int i = 0; i < error.animes.length; i++) {
        _animeNames[i] = error.toString();
      }
      isLoading = false;
      isDone = true;
      hasData = false;
      hasError = true;
    });
  }

  //search return
  Future<Anime> getAnimeByName(String searchValue) async {
    final response = await http.get(Uri.parse(
        "${Env.URL_PREFIX}/api/anime_search/?anime_name=$searchValue"));
    final items = json.decode(response.body); //.cast<Map<String, dynamic>>();
    //print(items);
    Anime anime = Anime.fromJson(items);
    // Anime anime = items((json) {
    //   return Anime.fromJson(json);
    // });
    return anime;
  }

  Future<AnimeList> getAnimeListByGenre(String searchValue) async {
    final response = await http.get(
        Uri.parse('${Env.URL_PREFIX}/api/anime_search/?genre=$searchValue'));
    final items = json.decode(response.body);
    print(items);
    AnimeList animes = AnimeList.fromJson(items);

    return animes;
  }

  Future<AnimeList> getAnimeListByStudio(String searchValue) async {
    final response = await http.get(
        Uri.parse('${Env.URL_PREFIX}/api/anime_search/?producer=$searchValue'));
    final items = json.decode(response.body);
    print(items);
    AnimeList animes = AnimeList.fromJson(items);

    return animes;
  }

  Future<AnimeList> getAnimeListByScore(String searchValue) async {
    final response = await http.get(
        Uri.parse('${Env.URL_PREFIX}/api/anime_search/?score=$searchValue'));
    final items = json.decode(response.body);
    print(items);
    AnimeList animes = AnimeList.fromJson(items);

    return animes;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          key: animeKey,
          width: 500,
          height: 50,
          decoration: BoxDecoration(
            //backgroundBlendMode: BlendMode.lighten,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[850]!.withOpacity(0.5),
                spreadRadius: 6,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              )
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            gradient: const LinearGradient(
                colors: [spiritedAwayGreen, spiritedAwayDarkBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.clamp),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<AnimeList>(
                future: _animeList,
                builder:
                    (BuildContext context, AsyncSnapshot<AnimeList> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      print('Loading...');
                      break;
                    case ConnectionState.active:
                      print('Active');
                      break;
                    case ConnectionState.none:
                      print('No connection');
                      break;
                    default:
                      if (snapshot.hasError) {
                        print(
                            'Error: ${snapshot.error}'); //${snapshot.data!.animes[0].name}');
                      } else {
                        print('Result: ');
                      } //${snapshot.data!.animes[0].name}');
                  }
                  if (snapshot.hasData) {
                    return Autocomplete<String>(
                      //change to <Anime>
                      //allow us to customize textfield portion
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextField(
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          decoration: const InputDecoration(
                            hintText: 'anime_search',
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 20.0,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600),
                        );
                      },
                      //Edit for changing search by value
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        switch (dropdownValue) {
                          case 'name':
                            return _animeNames.where((String anime) => anime
                                .toLowerCase()
                                .startsWith(
                                    textEditingValue.text.toLowerCase()));

                          case 'genre':
                            return animeGenres.where((String genre) => genre
                                .toLowerCase()
                                .startsWith(
                                    textEditingValue.text.toLowerCase()));

                          case 'studio':
                            return animeStudios.where((String studio) => studio
                                .toLowerCase()
                                .startsWith(
                                    textEditingValue.text.toLowerCase()));

                          case 'score':
                            return animeScores.where((String score) => score
                                .toLowerCase()
                                .startsWith(
                                    textEditingValue.text.toLowerCase()));
                        }
                        ;
                        return ['Unknown'];
                      },
                      //customize autocomplete output with optionsViewBuilder
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            shadowColor: Colors.grey,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              width: 475,
                              height: options.length * 50 as double,
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(5.0),
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final String option =
                                        options.elementAt(index);

                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(
                                          option,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        );
                      },
                      //we will change this to select an Anime and navigator.push(context) to anime_page
                      onSelected: (String selection) async {
                        print('You just selected ${selection}');
                        switch (dropdownValue) {
                          case 'name':
                            searchedAnime = await getAnimeByName(selection);
                            setState(() {
                              Navigator.pushNamed(context, SearchResultPage.id,
                                  arguments: SearchResultsArguments(
                                      anime: searchedAnime));
                            });
                            break;
                          case 'genre':
                            searchedList = await getAnimeListByGenre(selection);
                            setState(() {
                              Navigator.pushNamed(
                                  context, ListSearchResultPage.id,
                                  arguments: ListSearchResultsArguments(
                                      animes: searchedList));
                            });
                            break;
                          case 'studio':
                            searchedList =
                                await getAnimeListByStudio(selection);
                            setState(() {
                              Navigator.pushNamed(
                                  context, ListSearchResultPage.id,
                                  arguments: ListSearchResultsArguments(
                                      animes: searchedList));
                            });
                            break;
                          case 'score':
                            searchedList = await getAnimeListByScore(selection);
                            setState(() {
                              Navigator.pushNamed(
                                  context, ListSearchResultPage.id,
                                  arguments: ListSearchResultsArguments(
                                      animes: searchedList));
                            });
                            break;
                        }
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: spiritedAwayDarkBlue,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[850]!.withOpacity(0.5),
                spreadRadius: 6,
                blurRadius: 7,
                offset: const Offset(3, 0), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: DropdownButton<String>(
              dropdownColor: spiritedAwayDarkBlue,
              value: dropdownValue,
              icon: const Icon(
                Icons.keyboard_arrow_down_sharp,
              ),
              iconSize: 24,
              //elevation: 20,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w200,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: _searchBy.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
