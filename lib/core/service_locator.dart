import 'package:get_it/get_it.dart';
import 'package:khaltabita/user/data/data_source/base_remote_data_source.dart';
import 'package:khaltabita/user/data/data_source/remote_data_source.dart';
import 'package:khaltabita/user/data/repository/user_repository.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/get_all_book_in_one_category_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_book_categories.dart';
import 'package:khaltabita/user/domin/usecase/get_specific_book_usecase.dart';
import 'package:khaltabita/user/domin/usecase/register_usecase.dart';

final instance = GetIt.instance;

class ServiceLocator {
  void init() {
    //useCase
    instance.registerLazySingleton<GetBookCategoriesUseCase>(
        () => GetBookCategoriesUseCase(instance()));
    instance.registerLazySingleton<GetAllBookInOneCategoryUsecase>(
        () => GetAllBookInOneCategoryUsecase(instance()));
    instance.registerLazySingleton<GetSpecificBookUsecase>(
        () => GetSpecificBookUsecase(instance()));
    instance.registerLazySingleton<RegisterUsecase>(()=>RegisterUsecase(instance()));

    //repository
    instance.registerLazySingleton<BaseRepository>(
        () => UserRepository(instance()));

    //remoteDataSource
    instance
        .registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());
  }
}
