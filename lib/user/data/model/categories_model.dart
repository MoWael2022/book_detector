import 'package:khaltabita/user/domin/entites/categories.dart';

class CategoryModel extends Categories {
  CategoryModel({required super.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(categoryName: json['categories']);
  }
}
