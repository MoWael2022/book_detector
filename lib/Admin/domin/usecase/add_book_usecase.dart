import 'package:dartz/dartz.dart';
import 'package:khaltabita/Admin/domin/entites/book_data_entites.dart';
import 'package:khaltabita/Admin/domin/entites/datapasses.dart';
import 'package:khaltabita/Admin/domin/repository/base_admi_repository.dart';
import 'package:khaltabita/core/error/category_failure.dart';

import '../entites/book_data_input.dart';
import 'base_admin_usecase.dart';

class AddBookUseCase extends BaseAdminUseCase<DataPasses,BookData>{
  final BaseAdminRepository _baseAdminRepository;
  AddBookUseCase(this._baseAdminRepository);
  @override
  Future<Either<Failure, BookData>> call(DataPasses input) async {
    return await _baseAdminRepository.addBookRepository(input.bookDataInput,input.token);
  }

}