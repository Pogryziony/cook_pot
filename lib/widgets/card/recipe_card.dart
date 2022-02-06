import 'package:cook_pot/modules/recipes/appetizers/recipe_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard(
      {required this.recipeName,
      required this.assetPath,
      required this.callbackFunction,
      required this.portions,
      required this.difficulty,
      required this.preparationTime});

  final String recipeName;
  final String assetPath;
  final String preparationTime;
  final String portions;
  final String difficulty;
  final VoidCallback callbackFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.lightGreen.shade100,
      child: InkWell(
        onTap: callbackFunction,
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 150,
              width: 150,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.network(assetPath).image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 15)),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    recipeName,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 80),
                      ),
                      chooseDifficultyIconOnRecipeCard(difficulty),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Text(
                        difficulty,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Icon(
                        Icons.access_time,
                        size: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Text(
                        preparationTime + ' min',
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Icon(Icons.person, size: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Text(
                        portions,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

chooseDifficultyIconOnRecipeCard(difficulty) {
  if (difficulty == "Easy") {
    return Icon(
      MaterialCommunityIcons.signal_cellular_1,
      size: 20,
    );
  } else if (difficulty == "Medium") {
    return Icon(
      MaterialCommunityIcons.signal_cellular_2,
      size: 20,
    );
  } else if (difficulty == 'Hard')
    return Icon(
      MaterialCommunityIcons.signal_cellular_3,
      size: 20,
    );
}
