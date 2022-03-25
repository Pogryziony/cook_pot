import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

class Recipe extends Equatable {
  Recipe({
    required this.name,
    required this.image,
    required this.difficulty,
    required this.type,
    required this.portions,
    required this.preparationTime,
    required this.preparationSteps,
    required this.ingredients,
  });

  final String name;
  final String image;
  final String difficulty;
  final String type;
  final String portions;
  final double preparationTime;
  final List<dynamic> preparationSteps;
  final List<dynamic> ingredients;

  factory Recipe.fromJson(String str) => Recipe.fromMap(json.decode(str));

  String toJson() => json.encode(toDatabaseJson());

  factory Recipe.fromMap(Map<String, dynamic> json) => Recipe(
        name: json["name"],
        image: json["image"],
        difficulty: json["difficulty"],
        type: json["type"],
        portions: json["portions"],
        preparationTime: json["preparationTime"].toDouble(),
        preparationSteps:
            List<PreparationStep>.from(json["preparationSteps"].map((x) => PreparationStep.fromMap(x))),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromMap(x))),
      );

  Map<String, dynamic> toDatabaseJson() => {
        "name": name,
        "image": image,
        "difficulty": difficulty,
        "type": type,
        "portions": portions,
        "preparationTime": preparationTime,
        "preparationSteps": List<dynamic>.from(preparationSteps.map((x) => x.toMap())),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toMap())),
      };

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Recipe(
      name: data['name'] as String,
      image: data['image'] as String,
      difficulty: data['difficulty'] as String,
      ingredients: data['ingredients'],
      preparationTime: data['preparationTime'],
      preparationSteps: data['preparationSteps'],
      type: data['type'] as String,
      portions: data['portions'] as String,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Ingredient {
  Ingredient({
    required this.name,
    required this.quantity,
  });

  final String name;
  final String quantity;

  factory Ingredient.fromJson(String str) =>
      Ingredient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "quantity": quantity,
      };
}

class PreparationStep {
  PreparationStep({
    required this.step,
  });

  final String step;

  factory PreparationStep.fromJson(String str) =>
      PreparationStep.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PreparationStep.fromMap(Map<String, dynamic> json) => PreparationStep(
        step: json["step"],
      );

  Map<String, dynamic> toMap() => {
        "step": step,
      };
}
