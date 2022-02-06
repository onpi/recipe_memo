import 'package:recipe_memo/model/ingredient.dart';

class Recipe {
  String title;
  String? image_path;
  List<dynamic>? ingredients;
  String description;
  String user_id;
  String? storage_path;
  DateTime? created_at;
  DateTime? updated_at;

  Recipe({
    required this.title,
    this.image_path,
    this.ingredients,
    required this.description,
    required this.user_id,
    this.storage_path,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'image_path': this.image_path,
      'ingredients': this.ingredients,
      'description': this.description, // Dateはそのまま渡せる
      'user_id': this.user_id,
      'storage_path': this.storage_path,
      'created_at': this.created_at,
      'updated_at': this.updated_at,
    };
  }
}
