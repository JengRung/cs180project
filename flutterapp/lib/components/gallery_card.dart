import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutterapp/colors.dart';
import 'package:flutterapp/components/all.dart';
import 'package:flutterapp/models/all.dart';

class GalleryCard extends StatefulWidget {
  final Anime anime;
  const GalleryCard({Key? key, required this.anime}) : super(key: key);

  @override
  _GalleryCardState createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> {
  late Anime currentAnime;
  @override
  void initState() {
    super.initState();
    currentAnime = widget.anime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomLeft,
        height: 250,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
          gradient: const LinearGradient(
            colors: [spiritedAwayGreen, spiritedAwayDarkBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.clamp,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentAnime.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSansJP',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'score: ${currentAnime.score}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSansJP',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ));
  }
}
//CardDescription Overlay
// Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text('Anime'),
//               ),
//               Expanded(
//                 child: Container(
//                   alignment: Alignment.bottomCenter,
//                   height: 250,
//                   width: 150,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         spreadRadius: 3.0,
//                         blurRadius: 3.0,
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(
//                       20.0,
//                     ),
//                     color: Colors.grey.withOpacity(0.2),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),