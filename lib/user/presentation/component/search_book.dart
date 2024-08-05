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

class CustomBookSearch extends SearchDelegate {
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
    return const Text("data");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Book> filteredBook = BlocProvider
        .of<AppCubit>(context)
        .allBook
        .where((element) => element.title.startsWith(query))
        .toList();
    return ListView(
      children: filteredBook.map((e) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w, vertical: 2.h),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              e.urlImage,
              height: 15.h,
              width: 7.h,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            e.title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            e.author,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
        );
      }).toList(),
    );
  }
}