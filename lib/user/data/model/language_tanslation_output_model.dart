import 'package:khaltabita/user/data/model/language_translation_input_model.dart';
import 'package:khaltabita/user/domin/entites/language_translation_output_entities.dart';

class LanguageTranslationOutputModel extends LanguageTranslationOutputEntities {
  LanguageTranslationOutputModel({required super.translatedText});

  factory LanguageTranslationOutputModel.fromJson(Map<String, dynamic> json) {
    return LanguageTranslationOutputModel(
        translatedText: json["data"]["translations"]["translatedText"]);
  }
}
