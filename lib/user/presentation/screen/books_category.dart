import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/component/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/functions.dart';
import '../../domin/entites/book_entites.dart';
import '../component/book_component.dart';
import '../controller/app_cubit.dart';
import '../controller/app_state.dart';

class BookCategoryPage extends StatefulWidget {
  const BookCategoryPage({super.key});

  @override
  State<BookCategoryPage> createState() => _BookCategoryPageState();
}

class _BookCategoryPageState extends State<BookCategoryPage> {

  // @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<AppCubit>(context)
  //       .fetchBookInCategory(BlocProvider.of<AppCubit>(context).catName);
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          BlocProvider.of<AppCubit>(context).fetchData();
          BlocProvider.of<AppCubit>(context)
              .fetchSpecificBook(BlocProvider.of<AppCubit>(context).bookName);
        }
      },
      child: CustomPage(
          page: FutureBuilder<List<Book>>(
              future: BlocProvider.of<AppCubit>(context).fetchBookInCategory(
                  BlocProvider.of<AppCubit>(context).catName),
              builder: (context, snapshot) {
                return SizedBox(
                  height: 158.h,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0.w),
                        child: Text(
                          BlocProvider.of<AppCubit>(context)
                              .catName
                              .categoryName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 5.w),
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<AppCubit, AppState>(
                            builder: (context, state) {
                          if (state is LoadingBookFromCategoryState) {
                            return Functions.loadingLottie();
                          } else if (state is LoadedBookFromCategoryState) {
                            BlocProvider.of<AppCubit>(context)
                                .booksInCategories = state.data;
                            return ListView(
                              padding: EdgeInsets.all(5.w),
                              children: [
                                Wrap(
                                  children: snapshot.data!.map((category) {
                                    return BookComponent(
                                      bookName: category.title,
                                      rate: category.averageRating,
                                      imagePath: category.urlImage,
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          } else if (state is ErrorLoadBookFromCategoryState) {
                            return Center(
                              child: Text(state.failure.messageError),
                            );
                          } else {
                            return Functions.loadingLottie();
                          }
                        }),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
