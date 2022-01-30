import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String? name;
  final String? image;
  final String? difficulty;
  final List? ingredients;
  final String? preparationTime;
  final List? preparationSteps;
  final List? tags;
  final String? type;
  final double? ratings;
  final String? portions;

  Recipe(
      {this.name,
      this.image,
      this.difficulty,
      this.ingredients,
      this.preparationTime,
      this.preparationSteps,
      this.tags,
      this.type,
      this.ratings,
      this.portions});

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Recipe(
      name: data['name'] as String,
      image: data['image'] as String,
      difficulty: data['difficulty'] as String,
      ingredients: data['ingredients'] as List,
      preparationTime: data['preparationTime'],
      preparationSteps: data['preparationSteps'] as List,
      tags: data['tags'] as List,
      type: data['type'] as String,
      ratings: data['ratings'] as double,
      portions: data['portions'] as String,
    );
  }

   Map<String,dynamic> toDatabaseJson() => {
      'name': this.name,
      'image': this.image,
      'difficulty': this.difficulty,
      'ingredients': this.ingredients,
      'preparationTime': this.preparationTime,
      'preparationSteps': this.preparationSteps,
      'tags': this.tags,
      'type': this.type,
      'ratings': this.ratings,
      'portions': this.portions,
    };

  @override
  List<Object?> get props => throw UnimplementedError();
}
