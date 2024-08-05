import 'package:dartz/dartz.dart';
import 'package:khaltabita/Admin/domin/entites/user_data_entites.dart';
import 'package:khaltabita/Admin/domin/repository/base_admi_repository.dart';
import 'package:khaltabita/Admin/domin/usecase/base_admin_usecase.dart';
import 'package:khaltabita/core/error/category_failure.dart';

class GetAllUserUseCase extends BaseAdminUseCase <String , List<UserDataEntities>>{
  final BaseAdminRepository _baseAdminRepository;
  GetAllUserUseCase(this._baseAdminRepository);
  @override
  Future<Either<Failure, List<UserDataEntities>>> call(String input) async {

    return await _baseAdminRepository.getAllUserRepository(input);
  }

}