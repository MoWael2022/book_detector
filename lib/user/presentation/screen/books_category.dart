import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/component/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';

import '../component/book_component.dart';
import '../controller/app_cubit.dart';
import '../controller/app_state.dart';

class BookCategoryPage extends StatefulWidget {
  const BookCategoryPage({super.key});

  @override
  State<BookCategoryPage> createState() => _BookCategoryPageState();
}

class _BookCategoryPageState extends State<BookCategoryPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppCubit>(context)
        .fetchBookInCategory(BlocProvider.of<AppCubit>(context).catName);

  }

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
          page: ListView(
        children: [
          const CustomTextFormField(),
          Padding(
            padding: EdgeInsets.all(5.w),
            child: Center(
              child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                if (state is LoadingBookFromCategoryState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedBookFromCategoryState) {
                  // for(int i =0 ; i<5;i++){
                  //   if(state.data[i]!=null){
                  //     BlocProvider.of<AppCubit>(context).saveBook.add(state.data[i]);
                  //   }else {
                  //     break;
                  //   }
                  //
                  // }


                  // print(state.data[0].category);
                  return Wrap(

                    children: state.data.map((category) {
                      return BookComponent(
                        bookName: category.title,
                        rate: category.averageRating,
                        imagePath: category.urlImage,
                      );
                    }).toList(),
                  );
                } else if (state is ErrorLoadBookFromCategoryState) {
                  return Text(state.failure.messageError);
                } else {
                  return Text("Bayz");
                }
              }),
            ),
          )
        ],
      )),
    );
  }
}
