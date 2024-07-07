import 'package:dartz/dartz.dart';
import 'package:khaltabita/Admin/domin/entites/data_passes_update.dart';
import 'package:khaltabita/core/error/category_failure.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';

import '../entites/book_data_entites.dart';
import '../entites/datapasses.dart';
import '../repository/base_admi_repository.dart';

class UpdateBookUseCase extends BaseUserUseCase<DataPassesUpdate,BookData> {
  final BaseAdminRepository _baseAdminRepository;
  UpdateBookUseCase(this._baseAdminRepository);

  @override
  Future<Either<Failure, BookData>> call(DataPassesUpdate input) async{
    return await _baseAdminRepository.updateBookRepository(input.bookDataInput,input.token,input.id);
  }


}