import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String? name;
  final String? image;
  final Map? ingredients;
  final int? preparationTime;
  final Map? preparationSteps;
  final Map? tags;
  final String? type;
  final double? ratings;



  Recipe({this.name,this.image,this.ingredients,this.preparationTime,this.preparationSteps,this.tags,this.type,this.ratings});

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Recipe(
        name: data['name'] as String,
        image: data['image'] as String,
        ingredients: data['ingredients'] as Map,
        preparationTime: data['preparationTime'] as int,
        preparationSteps: data['preparationSteps'] as Map,
        tags: data['tags'] as Map,
        type: data['type'] as String,
        ratings: data['ratings'] as double,
      );
    }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
