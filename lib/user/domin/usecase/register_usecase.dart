import 'package:dartz/dartz.dart';
import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/data/model/user_input_model.dart';
import 'package:khaltabita/user/data/model/user_model.dart';
import 'package:khaltabita/user/domin/entites/User.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';

class RegisterUsecase extends BaseUserUseCase<UserInputModel, User> {
  final BaseRepository _baseRepository;

  RegisterUsecase(this._baseRepository);

  @override
  Future<Either<Failure, User>> call(UserInputModel input) async {
    return await _baseRepository.registerRepository(input);
  }
}
