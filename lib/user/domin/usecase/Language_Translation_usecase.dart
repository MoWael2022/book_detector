import 'package:dartz/dartz.dart';
import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/data/model/language_translation_input_model.dart';
import 'package:khaltabita/user/domin/entites/lnaguage_translation_entites.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';

import '../entites/language_translation_output_entities.dart';

class LanguageTranslationUseCase extends BaseUserUseCase<
    LanguageTranslationInputModel, LanguageTranslationOutputEntities> {
  final BaseRepository _baseRepository ;
  LanguageTranslationUseCase(this._baseRepository);
  @override
  Future<Either<Failure, LanguageTranslationOutputEntities>> call(
      LanguageTranslationInputModel input) async {

    return await _baseRepository.languageTranslationRepository(input);
  }
}
