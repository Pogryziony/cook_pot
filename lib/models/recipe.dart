import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe extends Equatable{
  final String name;
  final String? image;
  final Map ingredients;
  final int preparationTime;
  final Map preparationSteps;
  final Map? tags;
  final double? ratings;
  final String type;

  const Recipe({
    required this.name,
    this.image,
    required this.ingredients,
    required this.preparationTime,
    required this.preparationSteps,
    this.tags,
    this.ratings,
    required this.type,
  });

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Recipe(
      name: data['name'] as String,
      image: data['image'] as String,
      ingredients: data['ingredients'] as Map,
      preparationTime: data['preparation_time'] as int,
      preparationSteps: data['preparation_steps'] as Map,
      tags: data['tags'] as Map,
      ratings: data['ratings'] as double,
      type: data['type'] as String,
    );
  }

  @override
  List<Object> get props => <Object> [
    name,
    image!,
    ingredients,
    preparationTime,
    preparationSteps,
    tags!,
    ratings!,
    type,
  ];

}