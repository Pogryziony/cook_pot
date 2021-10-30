import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({this.categoryName, this.assetPath, this.onPressed});

  final String categoryName;
  final String assetPath;

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Container(
          height: 200,
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
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = Colors.blueGrey.shade900.withAlpha(85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}