import 'package:dartz/dartz.dart';
import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';

import '../entites/book_entites.dart';

class GetSpecificBookUsecase extends BaseUserUseCase<BookNameEntities, Book> {
  final BaseRepository _baseRepository;

  GetSpecificBookUsecase(this._baseRepository);

  @override
  Future<Either<Failure, Book>> call(BookNameEntities input) async {
    return await _baseRepository.getSpecificBookRepository(input);
  }
}
