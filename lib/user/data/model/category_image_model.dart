import 'package:khaltabita/user/domin/entites/categoryImage.dart';

class CategoryImageModel extends CategoryImage {
  CategoryImageModel({required super.categoryImage});

  factory CategoryImageModel.fromJson(Map<String, dynamic> json) {
    return CategoryImageModel(categoryImage: json['url_image']);
  }
}
