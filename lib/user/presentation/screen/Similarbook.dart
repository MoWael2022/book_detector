import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/router.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:sizer/sizer.dart';

import '../controller/app_cubit.dart';

class SimilarBook extends StatelessWidget {
  const SimilarBook({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      page: ListView.builder(
        itemCount: BlocProvider.of<AppCubit>(context).similarBooks.length,
        itemBuilder: (context, index) {
          final book = BlocProvider.of<AppCubit>(context).similarBooks[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(Routers.bookDescription);
                  BlocProvider.of<AppCubit>(context).bookName.bookName = book.title;
                  BlocProvider.of<AppCubit>(context).getSimilarbook(CategoryNameEntities(categoryName: book.category));
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    book.urlImage,
                    height: 15.h,
                    width: 7.h,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  book.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  book.author, // Assuming there's an author field
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}
