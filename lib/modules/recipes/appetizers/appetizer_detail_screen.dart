import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class AppetizerDetailScreen extends StatefulWidget {
  var index;
  var name;
  var image;
  var preparationTime;
  var difficulty;
  var ingredients;
  var preparationSteps;
  var portions;

  AppetizerDetailScreen({
    this.index,
    this.name,
    this.image,
    this.preparationTime,
    this.difficulty,
    this.ingredients,
    this.preparationSteps,
    this.portions,
  });

  @override
  _AppetizerDetailScreenState createState() => _AppetizerDetailScreenState();
}

class _AppetizerDetailScreenState extends State<AppetizerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        color: Colors.lightGreen.shade100,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: NetworkImage(widget.image),
                fit: BoxFit.fill,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Center(
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    chooseDifficultyIcon(widget.difficulty),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(widget.difficulty,
                        style: TextStyle(
                            fontSize: 24, fontStyle: FontStyle.italic)),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Row(
                  children: [
                    Icon(Icons.access_time),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(widget.preparationTime + ' min',
                        style: TextStyle(
                            fontSize: 24, fontStyle: FontStyle.italic)),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Row(
                  children: [
                    Icon(Icons.person),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(widget.portions,
                        style: TextStyle(
                            fontSize: 24, fontStyle: FontStyle.italic)),
                  ],
                ),
              ],
            ),
            Text('Ingredients:'),
            getTextWidgets(widget.ingredients),
          ],
        ),
      ),
    );
  }
}

chooseDifficultyIcon(difficulty) {
  if (difficulty == "Easy") {
    return Icon(
      MaterialCommunityIcons.signal_cellular_1,
      size: 36,
    );
  } else if (difficulty == "Medium") {
    return Icon(MaterialCommunityIcons.signal_cellular_2, size: 36);
  } else if (difficulty == 'Hard')
    return Icon(MaterialCommunityIcons.signal_cellular_3, size: 36);
}

Widget getTextWidgets(List<dynamic> strings) {
  return new Column(children: strings.map((item) => new Text(item)).toList());
}
// Row(
//   children: [
//     Container(
//       child: RatingBar.builder(
//         initialRating: 3,
//         minRating: 1,
//         direction: Axis.horizontal,
//         itemCount: 5,
//         itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
//         itemSize: 25,
//         itemBuilder: (context, _) => Icon(
//           Icons.star,
//           color: Colors.amber,
//         ),
//         onRatingUpdate: (rating) {
//           print(rating);
//         },
//       ),
//     ),
//     Container(
//       child: IconButton(
//         onPressed: () => {
//          //todo: state for checking favourite button
//         },
//         icon: Icon(
//             Icons.favorite_border,
//             color: Colors.red,
//             ),
//       )
//     )
//   ],
// ),
