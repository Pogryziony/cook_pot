import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({required this.recipeName, required this.assetPath, required this.onPressed, required this.preparationTime});
  final String recipeName;
  final String assetPath;
  final int preparationTime;
  /// Callback that fires when the user taps on this widgets
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(assetPath),
                fit: BoxFit.fitWidth,
                alignment: Alignment.center),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                recipeName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = Colors.blueGrey.shade900.withAlpha(85),
                ),
              ),
              Text(
                preparationTime.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = Colors.blueGrey.shade900.withAlpha(85),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}