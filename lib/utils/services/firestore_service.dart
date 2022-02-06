import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_pot/models/recipe.dart';

class FirestoreService {
  final FirebaseFirestore _databaseInstance = FirebaseFirestore.instance;

  Future<List<Recipe>> getRecipes() {
    final CollectionReference<Map<String, dynamic>> reference =
        _databaseInstance.collection('recipes');
    return reference.get().then(
        (QuerySnapshot<Map<String, dynamic>> snapshot) => snapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                Recipe.fromFirestore(doc))
            .toList());
  }

  Future<List<Recipe>> getRecipesFromCategory(String category) {
    final Query<Map<String, dynamic>> reference = _databaseInstance
        .collection('recipes')
        .where('type', isEqualTo: '$category');
    return reference.get().then(
        (QuerySnapshot<Map<String, dynamic>> snapshot) => snapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                Recipe.fromFirestore(doc))
            .toList());
  }

  Future<void> addNewRecipe(Recipe recipe) {
    var reference = _databaseInstance.collection('recipes');
    return reference
        .add(recipe.toDatabaseJson())
        // ignore: return_of_invalid_type_from_catch_error
        .catchError((error) => print(error));
  }
}
