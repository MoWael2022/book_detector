import 'package:dartz/dartz.dart';
import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';

import '../entites/book_entites.dart';

class GetAllBookUseCase extends BaseUserUseCase<NoParameter, List<Book>> {
  final BaseRepository _baseRepository;

  GetAllBookUseCase(this._baseRepository);

  @override
  Future<Either<Failure, List<Book>>> call(NoParameter input) async {
    return await _baseRepository.getAllBookRepository();
  }
}
