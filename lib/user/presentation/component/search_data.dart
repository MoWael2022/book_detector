import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/user/domin/entites/categories.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/images_path.dart';
import '../../domin/entites/book_entites.dart';
import '../controller/app_cubit.dart';
import '../controller/app_state.dart';
import 'book_component.dart';
import 'category_component.dart';

class CustomSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("data");
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return ListView(
      children: [

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
                  List<Categories>? categories = state.data;
                  List<Categories> filterproduct = state.data!
                      .where((element) => element.categoryName.startsWith(query))
                      .toList();
                  //print(state.data[0].categoryName);
                  return Wrap(
                    children: filterproduct==null ? categories.map((category) {
                      return CategoryComponent(
                        bookName: category.categoryName,
                        rate: "4.5",
                        imagePath: "assets/book test.png",
                      );
                    }).toList() : filterproduct.map((category) {
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
// ListView(
// children: [
//
// Padding(
// padding: EdgeInsets.all(5.w),
// child: Center(
// child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
// if (state is LoadingBookFromCategoryState) {
// return const Center(
// child: CircularProgressIndicator(),
// );
// } else if (state is LoadedBookFromCategoryState) {
// // for(int i =0 ; i<5;i++){
// //   if(state.data[i]!=null){
// //     BlocProvider.of<AppCubit>(context).saveBook.add(state.data[i]);
// //   }else {
// //     break;
// //   }
// //
// // }
//
//
// // print(state.data[0].category);
// return Wrap(
//
// children: state.data.map((category) {
// return BookComponent(
// bookName: category.title,
// rate: category.averageRating,
// imagePath: category.urlImage,
// );
// }).toList(),
// );
// } else if (state is ErrorLoadBookFromCategoryState) {
// return Text(state.failure.messageError);
// } else {
// return Text("Bayz");
// }
// }),
// ),
// )
// ],
// );
