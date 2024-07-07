import 'package:dartz/dartz.dart';
import 'package:khaltabita/core/error/category_failure.dart';

abstract class BaseAdminUseCase<In, Out> {
  Future<Either<Failure, Out>> call(In input);
}

class NoParameter {
  const NoParameter();
}
