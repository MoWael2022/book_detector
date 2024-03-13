import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_all_book_in_one_category_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_book_categories.dart';
import 'package:khaltabita/user/presentation/component/drawer_component.dart';
import 'package:khaltabita/user/presentation/controller/app_state.dart';
import 'package:sizer/sizer.dart';

import '../../../core/enums.dart';
import '../../domin/entites/categories.dart';
import '../component/drawer_component_selected.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitState()){
    fetchData();
  }

  CategoryNameEntities catName = CategoryNameEntities(categoryName: "");
  List<Categories> saveCategory =[];

  void fetchData() async {
    emit(LoadingCategoryDataState());
    final result = instance<GetBookCategoriesUseCase>();
    final data = await result.call(const NoParameter());

    data.fold((l) {
      emit(ErrorCategoryDataState(failure: l));
      return l.messageError;
    }, (r) {
      emit(LoadedCategoryDataState(data: r));
      saveCategory = r;
      return r;
    });
  }

  void fetchBookInCategory(CategoryNameEntities input) async {
    emit(LoadingBookFromCategoryState());
    final result = instance<GetAllBookInOneCategoryUsecase>();
    final data = await result.call(input);

    data.fold((l) {
      emit(ErrorLoadBookFromCategoryState(failure: l));
      return l.messageError;
    }, (r) {
      emit(LoadedBookFromCategoryState(data: r));
      return r;
    });
  }
}
