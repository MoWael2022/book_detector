import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:khaltabita/Admin/domin/usecase/base_admin_usecase.dart';
import 'package:khaltabita/core/error/category_failure.dart';

import '../entites/book_data_entites.dart';
import '../entites/data_passes_delete.dart';
import '../repository/base_admi_repository.dart';

class DeleteBookUseCase extends BaseAdminUseCase<DataPassesDelete,BookData>{
  final BaseAdminRepository _baseAdminRepository;
  DeleteBookUseCase(this._baseAdminRepository);

  @override
  Future<Either<Failure, BookData>> call(DataPassesDelete input) async {
    return await _baseAdminRepository.deleteBookRepository(input.token,input.id);
  }
}