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

  Future<List<Recipe>> getRecipesFromCategory(String category) {
    final Query<Map<String, dynamic>> ref =
        _db.collection('recipes').where('type', isEqualTo: '$category');
    return ref.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) =>
        snapshot
            .docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                Recipe.fromFirestore(doc))
            .toList());
  }

  Future<List<Recipe>> getRecipesFromCategoryWithFilters(String category) {
    final Query<Map<String, dynamic>> ref = _db
        .collection('recipes')
        .where('type', isEqualTo: '$category')
        .where('difficulty', isEqualTo: 'Easy'); //todo dodać filtrowanie
    return ref.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) =>
        snapshot
            .docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                Recipe.fromFirestore(doc))
            .toList());
  }
}
