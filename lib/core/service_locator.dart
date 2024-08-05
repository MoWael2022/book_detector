import 'package:get_it/get_it.dart';
import 'package:khaltabita/Admin/domin/usecase/get_all_user_usecase.dart';
import 'package:khaltabita/user/data/data_source/base_remote_data_source.dart';
import 'package:khaltabita/user/data/data_source/remote_data_source.dart';
import 'package:khaltabita/user/data/repository/user_repository.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/Language_Translation_usecase.dart';
import 'package:khaltabita/user/domin/usecase/connectivity_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_all_book_in_one_category_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_all_book_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_book_categories.dart';
import 'package:khaltabita/user/domin/usecase/get_category_image.dart';
import 'package:khaltabita/user/domin/usecase/get_specific_book_usecase.dart';
import 'package:khaltabita/user/domin/usecase/register_usecase.dart';

import '../Admin/data/datasource/base_remote_data_source.dart';
import '../Admin/data/datasource/remote_data_source.dart';
import '../Admin/data/repository/admin_repository.dart';
import '../Admin/domin/repository/base_admi_repository.dart';
import '../Admin/domin/usecase/add_book_usecase.dart';
import '../Admin/domin/usecase/delete_book_usecase.dart';
import '../Admin/domin/usecase/update_book_usecase.dart';
import '../user/domin/usecase/login_usecase.dart';

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
    instance.registerLazySingleton<RegisterUsecase>(
        () => RegisterUsecase(instance()));
    instance
        .registerLazySingleton<LoginUsecase>(() => LoginUsecase(instance()));
    instance.registerLazySingleton<LanguageTranslationUseCase>(
        () => LanguageTranslationUseCase(instance()));
    instance.registerLazySingleton<GetAllBookUseCase>(
            () => GetAllBookUseCase(instance()));
    instance.registerLazySingleton<ConnectivityUseCase>(
            () => ConnectivityUseCase(instance()));
    instance.registerLazySingleton<GetCategoryImageUseCase>(
            () => GetCategoryImageUseCase(instance()));


    //repository
    instance.registerLazySingleton<BaseRepository>(
        () => UserRepository(instance()));

    //remoteDataSource
    instance
        .registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());

    //admin Service locator

    //useCase
    instance.registerLazySingleton<AddBookUseCase>(
        () => AddBookUseCase(instance()));
    instance.registerLazySingleton<DeleteBookUseCase>(
            () => DeleteBookUseCase(instance()));
    instance.registerLazySingleton<UpdateBookUseCase>(
            () => UpdateBookUseCase(instance()));
    instance.registerLazySingleton<GetAllUserUseCase>(
            () => GetAllUserUseCase(instance()));

    //repository
    instance.registerLazySingleton<BaseAdminRepository>(
        () => AdminRepository(instance()));

    //remoteDataSource
    instance.registerLazySingleton<BaseAdminRemoteDataSource>(
        () => AdminRemoteDataSource());

  }
}
