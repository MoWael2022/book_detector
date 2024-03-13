import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:khaltabita/user/domin/usecase/get_all_book_in_one_category_usecase.dart';

import 'package:khaltabita/user/presentation/component/category_component.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/component/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../controller/app_cubit.dart';
import '../controller/app_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    final result = instance<GetAllBookInOneCategoryUsecase>();
    final data =
        await result.call(CategoryNameEntities(categoryName: "Actors"));
    print(data.fold((l) => {}, (r) => {r[0].id, r[0].description}));
  }

  @override
  void initState() {
    super.initState();
    getData();
    //BlocProvider.of<AppCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      page: ListView(
        children: [
          const CustomTextFormField(),
          Padding(
            padding: EdgeInsets.all(5.w),
            child: Center(
              child: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  if (state is LoadingCategoryDataState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedCategoryDataState) {
                    print(state.data[0].categoryName);
                    return Wrap(
                      children: BlocProvider.of<AppCubit>(context).saveCategory.map((category) {
                        return CategoryComponent(
                          bookName: category.categoryName,
                          rate: "4.5",
                          imagePath: "assets/book test.png",
                        );
                      }).toList(),
                    );
                  } else if (state is ErrorCategoryDataState) {
                    return Text(state.failure.messageError);
                  } else {
                    return Text("Bayz");
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
