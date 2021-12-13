import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard(
      {required this.recipeName,
      required this.assetPath,
      required this.callbackFunction,
      required this.preparationTime});

  final String recipeName;
  final String assetPath;
  final String preparationTime;
  final VoidCallback callbackFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callbackFunction,
      child: Card(
        child: Row(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(assetPath).image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  recipeName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  preparationTime.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                Row(
                  children: [
                    Container(
                      child: RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemSize: 25,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () => {
                         //todo: state for checking favourite button
                        },
                        icon: Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            ),
                      )
                    )
                  ],
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
