import 'package:dartz/dartz.dart';
import 'package:khaltabita/Admin/domin/usecase/base_admin_usecase.dart';
import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/domin/entites/categoryImage.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';

class GetCategoryImageUseCase extends BaseAdminUseCase<String, CategoryImage> {
  final BaseRepository _baseRepository;

  GetCategoryImageUseCase(this._baseRepository);

  @override
  Future<Either<Failure, CategoryImage>> call(String nameCategory) async {
    return await _baseRepository.getCategoryImage(nameCategory);
  }
}
