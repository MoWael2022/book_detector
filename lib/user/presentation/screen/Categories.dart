import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/user/domin/entites/categories.dart';
import 'package:khaltabita/user/presentation/component/category_component.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/component/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/functions.dart';
import '../component/dialogs_component.dart';
import '../component/search_book.dart';
import '../component/search_data.dart';
import '../controller/app_cubit.dart';
import '../controller/app_state.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  static const int numberOfElement = 483;
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _loadedCategory = [];
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    _loadMoreCategories();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreCategories();
      }
    });
  }

  void _loadMoreCategories() {
    if (_currentMax >= numberOfElement) return;
    setState(() {
      _currentMax = (_currentMax + 10) > numberOfElement
          ? numberOfElement
          : _currentMax + 10;
      _loadedCategory =
          BlocProvider.of<AppCubit>(context).categories.sublist(0, _currentMax);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      page: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 7.w),
                        ),
                        IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context, delegate: CustomSearch());
                            },
                            icon: const Icon(Icons.search))
                      ],
                    ),
                  ),
                  // const CustomTextFormField(),
                  Expanded(
                    child: BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) {
                        if (state is LoadingCategoryDataState) {
                          return Functions.loadingLottie();
                        }
                        else if (state is LoadedCategoryDataState) {
                          return ListView(
                            controller: _scrollController,
                            padding: EdgeInsets.only(left: 8.w, right: 8.w),
                            children: [
                              Wrap(
                                children: _loadedCategory.map((category) {
                                  return CategoryComponent(
                                    bookName: category.categoryName,
                                    rate: "4.5",
                                    imagePath: BlocProvider.of<AppCubit>(context).allBook
                                        .firstWhere(
                                          (element) => element.category == category.categoryName,
                                    ).urlImage,
                                  );

                                }).toList(),
                              ),
                            ],
                          );
                        }
                        else if (state is ErrorCategoryDataState) {
                          return Center(
                            child: Text(state.failure.messageError),
                          );
                        }
                        else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],

      )


    );
  }
}
