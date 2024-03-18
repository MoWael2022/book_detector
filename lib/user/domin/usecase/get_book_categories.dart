import 'package:dartz/dartz.dart';
import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/domin/entites/categories.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';

class GetBookCategoriesUseCase extends BaseUserUseCase<NoParameter, List<Categories>> {
  final BaseRepository _baseRepository;

  GetBookCategoriesUseCase(this._baseRepository);

  @override
  Future<Either<Failure, List<Categories>>> call(NoParameter input) async {
    final result = await _baseRepository.getCategoriesRepository();
    //print("from useCase ${result.length()}");
    return result ;
  }
}
