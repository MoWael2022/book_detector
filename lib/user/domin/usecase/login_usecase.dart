import 'package:dartz/dartz.dart';
import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/domin/entites/input_login_data.dart';
import 'package:khaltabita/user/domin/entites/output_data.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';

import '../entites/User.dart';

class LoginUsecase extends BaseUserUseCase<InputLoginData, User> {
  final BaseRepository _baseRepository;

  LoginUsecase(this._baseRepository);

  @override
  Future<Either<Failure, User>> call(InputLoginData input) async {
    return await _baseRepository.loginRepository(input);
  }
}
