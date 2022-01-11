import 'package:flutter/material.dart';
import 'package:flutterapp/colors.dart';
import 'package:flutterapp/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModifyPage extends StatefulWidget {
  static String id = 'modify_page';
  const ModifyPage({Key? key}) : super(key: key);

  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  late TextEditingController _controller;
  Map<String, String> inputMap = {
    'name': '',
    'score': '',
    'ranking': '',
    'episodes': '',
    'type': '',
    'popularity': '',
  };

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        title: const Text(
          'アニメデータ',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NotoSansJP',
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modifyBar('name'),
            modifyBar('score'),
            modifyBar('ranking'),
            modifyBar('episodes'),
            modifyBar('type'),
            modifyBar('popularity'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                modifyButton('animeEdit', inputMap, 'Edit'),
                modifyButton('animeDelete', inputMap, 'Delete'),
                modifyButton('animeAdd', inputMap, 'Add'),
                modifyButton('backup', inputMap, 'Backup'),
                modifyButton('import', inputMap, 'Import'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget modifyButton(String func, Map<String, String> inputMap, String title) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: spiritedAwayDarkBlue,
          textStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'NotoSansJP',
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        onPressed: () async {
          final response;
          dynamic items;
          String output = '';
          switch (func) {
            case 'animeEdit':
              response = await http.get(Uri.parse(
                  "${Env.URL_PREFIX}/api/$func?name=${inputMap['name']}&score=${inputMap['score']}&ranking=${inputMap['ranking']}&episode=${inputMap['episodes']}&type=${inputMap['type']}&popularity=${inputMap['popularity']}"));
              items = json.decode(response.body);
              output = '${items['name']} has been added';
              break;
            case 'animeDelete':
              response = await http.get(Uri.parse(
                  "${Env.URL_PREFIX}/api/$func?name=${inputMap['name']}"));
              items = json.decode(response.body);
              output = '${items['name']} has been deleted';
              break;
            case 'animeAdd':
              response = await http.get(Uri.parse(
                  "${Env.URL_PREFIX}/api/$func?name=${inputMap['name']}&score=${inputMap['score']}&ranking=${inputMap['ranking']}&episode=${inputMap['episodes']}&type=${inputMap['type']}&popularity=${inputMap['popularity']}"));
              items = json.decode(response.body);
              output = '${items['name']} has been added';
              break;
            case 'backup':
              response =
                  await http.get(Uri.parse("${Env.URL_PREFIX}/api/$func"));
              items = json.decode(response.body);
              break;
            case 'import':
              response =
                  await http.get(Uri.parse("${Env.URL_PREFIX}/api/import"));
              items = json.decode(response.body).toString();
              output = items.toString();
              break;
          }
          print(items);
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("Called $func"),
                    content: Text(output),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("ok"),
                      ),
                    ],
                  ));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ));
  }

  Widget modifyBar(String input) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 25.0,
      ),
      child: Container(
        width: 500,
        height: 48,
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
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          gradient: const LinearGradient(
              colors: [spiritedAwayGreen, spiritedAwayDarkBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: input,
              hintStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400),
            ),
            onChanged: (value) {
              inputMap[input] = value;
            },
          ),
        ),
      ),
    );
  }
}
