import 'package:khaltabita/user/domin/entites/lnaguage_translation_entites.dart';

class LanguageTranslationInputModel extends LanguageTranslationInputEntities {
  LanguageTranslationInputModel({required super.query});

Map<String , String> toMap(){
  return {
    "q" : query ,
    "source" : source,
    "target" : targets,
  };
}

}