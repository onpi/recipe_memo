import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_memo/model/recipe.dart';
import 'package:recipe_memo/model/ingredient.dart';

class RecipeListModel {
  var currentUser = FirebaseAuth.instance.currentUser;
  List<Recipe> _datas = [];

  Future<List<Recipe>> getResipe() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('recipe')
        .where('user_id', isEqualTo: currentUser!.uid)
        .get();
    var docs = snapshot.docs;
    for (var doc in docs) {
      _datas.add(Recipe(
        title: doc.data()['title'],
        image_path: doc.data()['image_path'],
        ingredients: doc.data()['ingredients'],
        description: doc.data()['description'],
        user_id: doc.data()['user_id'],
        storage_path: doc.data()['storage_path'],
      ));
    }

    return _datas;
  }

  void reOrderItem(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _datas.removeAt(oldIndex);
    _datas.insert(newIndex, item);
  }
}
