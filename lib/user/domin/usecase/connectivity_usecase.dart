import 'package:dartz/dartz.dart';
import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';

import '../repository/base_user_repository.dart';

class ConnectivityUseCase extends BaseUserUseCase<NoParameter,bool> {
  final BaseRepository _baseRepository;
  ConnectivityUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(NoParameter input) async{
  return await _baseRepository.isConnectedRepo();

  }

}