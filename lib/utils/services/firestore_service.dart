import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_pot/models/recipe.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Recipe>> getRecipes() {
    final CollectionReference<Map<String, dynamic>> ref =
    _db.collection('recipes');
    return ref.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) =>
        snapshot
            .docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            Recipe.fromFirestore(doc))
            .toList());
  }

  Future<List<Recipe>> getAppetizers() {
    final Query<Map<String, dynamic>> ref =
    _db.collection('recipes').where('type',isEqualTo: 'appetizer');
    return ref.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) =>
        snapshot
            .docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            Recipe.fromFirestore(doc))
            .toList());
  }

  Future<List<Recipe>> getMainDishes() {
    final Query<Map<String, dynamic>> ref =
    _db.collection('recipes').where('type',isEqualTo: 'main dish');
    return ref.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) =>
        snapshot
            .docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            Recipe.fromFirestore(doc))
            .toList());
  }

  Future<List<Recipe>> getDesserts() {
    final Query<Map<String, dynamic>> ref =
    _db.collection('recipes').where('type',isEqualTo: 'dessert');
    return ref.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) =>
        snapshot
            .docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            Recipe.fromFirestore(doc))
            .toList());
  }

  Future<List<Recipe>> getDrinks() {
    final Query<Map<String, dynamic>> ref =
    _db.collection('recipes').where('type',isEqualTo: 'drink');
    return ref.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) =>
        snapshot
            .docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            Recipe.fromFirestore(doc))
            .toList());
  }
}
