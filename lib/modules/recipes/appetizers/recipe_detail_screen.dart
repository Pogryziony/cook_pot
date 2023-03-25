import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RecipeDetailScreen extends StatefulWidget {
  final index;
  final name;
  final image;
  final preparationTime;
  final difficulty;
  final ingredients;
  final preparationSteps;
  final portions;
  final stepIndex;

  RecipeDetailScreen({
    this.index,
    this.name,
    this.image,
    this.preparationTime,
    this.difficulty,
    this.ingredients,
    this.preparationSteps,
    this.portions,
    this.stepIndex = 0,
  });

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightGreen.shade100,
          child: Column(
            children: [
              SizedBox(
                height: 450,
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
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
              SizedBox(
                height: 17,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 3, color: Colors.lightGreen),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10))),
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: 250,
                child: ListView.builder(
                  itemBuilder: (context, index) => Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Text(
                              'Ingredient ${(index + 1)}',
                              style: Theme.of(context).textTheme.labelLarge,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                              fit: FlexFit.loose,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 160,
                                    child: Text(
                                      widget.ingredients[index]['name'].toString(),
                                      style: Theme.of(context).textTheme.bodyLarge,
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                      softWrap: false,
                                    ),
                                  ),
                                  Text(
                                    widget.ingredients[index]['quantity'].toString(),
                                    style: Theme.of(context).textTheme.bodyLarge,
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                    maxLines: 2,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  itemCount: widget.ingredients.length,
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 3, color: Colors.lightGreen),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(15))),
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: 300,
                child: ListView.builder(
                  itemBuilder: (context, index) => Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Text(
                              'Step ${(index + 1)}',
                              style: Theme.of(context).textTheme.labelLarge,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                widget.preparationSteps[index]['step'].toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                                overflow: TextOverflow.fade,
                                maxLines: 8,
                                softWrap: true,
                              ))
                        ],
                      ),
                    ),
                  ),
                  itemCount: widget.preparationSteps.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

chooseDifficultyIcon(difficulty) {
  if (difficulty == "Easy") {
    return Icon(
      MdiIcons.chevronUp,
      size: 36,
    );
  } else if (difficulty == "Medium") {
    return Icon(MdiIcons.chevronDoubleUp, size: 36);
  } else if (difficulty == 'Hard')
    return Icon(MdiIcons.chevronTripleUp, size: 36);
}

Widget getTextWidgets(List<dynamic> strings) {
  return new Column(children: strings.map((item) => new Text(item)).toList());
}

List<Text> returnList(List<dynamic> strings) {
  return strings.map((item) => new Text(item)).toList();
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
