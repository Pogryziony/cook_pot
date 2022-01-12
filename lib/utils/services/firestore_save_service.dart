import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreSaveService {
  final FirebaseFirestore _databaseInstance = FirebaseFirestore.instance;
  final String? name;
  final String? image;
  final String? difficulty;
  final List? ingredients;
  final double? preparationTime;
  final List? preparationSteps;
  final List? tags;
  final String? type;
  final double? ratings;
  final String? portions;

  FirestoreSaveService(
      {this.name,
      this.image,
      this.difficulty,
      this.ingredients,
      this.preparationTime,
      this.preparationSteps,
      this.tags,
      this.type,
      this.ratings,
      this.portions
      });

  saveData(
      {name,
      image,
      ingredients,
      difficulty,
      preparationTime,
      preparationSteps,
      tags,
      type,
      ratings,
      portions
      }) {
    _databaseInstance
        .collection('recipes')
        .add({
          'name': this.name,
          'image': this.image,
          'difficulty': this.difficulty,
          'ingredients': this.ingredients as List,
          'preparationTime': this.preparationTime!.toStringAsFixed(0),
          'preparationSteps': this.preparationSteps as List,
          'tags': this.tags as List,
          'type': this.type,
          'ratings': this.ratings,
          'portions': this.portions,
        })
        .then((value) => print('Recipe added'))
        .catchError((error) => print('Failed to add recipe'));
  }
}
