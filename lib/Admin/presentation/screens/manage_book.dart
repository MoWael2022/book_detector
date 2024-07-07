import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/Admin/presentation/component/custom_text_form_field.dart';
import 'package:khaltabita/Admin/presentation/controller/admin_cubit.dart';
import 'package:khaltabita/Admin/presentation/controller/admin_state.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../core/global_resources/constants.dart';

class ManageBook extends StatefulWidget {
  const ManageBook({super.key});

  @override
  State<ManageBook> createState() => _ManageBookState();
}

class _ManageBookState extends State<ManageBook> {

  Future<void> getData2() async {
    //String token = BlocProvider.of<AuthCubit>(context).currentUser!.token;
    String path = "https://demobookdetector.azurewebsites.net/book/add";
    Dio dio = Dio();

    FormData bookData = FormData.fromMap({
      "title": "khaltabita",
      "categories": "War",
      "authors": "authors",
      "description": "waeeeeeeeeel",
      "published_year": "2002",
      "average_rating": "3",
      "ratings_count": "5",
      "num_pages": "200",
      "url_image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTKP_9TF_DWqb0bNdKN_VQgEKfVimtQ5dc4g&s"
    });

    FormData loginData = FormData.fromMap({
      "Email": "NasserAdmin@gmail.com",
      "password": "Nasser@123",
    });

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJOYXNzZXJBZG1pbiIsImp0aSI6IjY4Y2MxMDY3LWUwZmQtNGIwNS04NDc1LWZkNjRiNDRiZjBjMCIsImVtYWlsIjoiTmFzc2VyQWRtaW5AZ21haWwuY29tIiwidWlkIjoiNjZmZjdkNWItZjNlYS00NmJjLTkyODQtYTAwOWUyNzQ2NjI4Iiwicm9sZXMiOlsiVXNlciIsIkFkbWluIl0sImV4cCI6MTcyMjAwODA3NCwiaXNzIjoiU2VjdXJlQXBpIiwiYXVkIjoiU2VjdXJlQXBpVXNlciJ9.fdNE4H65JJmBH0HY-OobuyjSdpf_5R4moIxMw2YFR2w',
    };

    try {

      // Attempt to add the book
      final response = await dio.post(
        path,
        data: bookData,
        options: Options(
          headers: headers,
          followRedirects: false,
          maxRedirects: 0,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      // if (response.statusCode == 302) {
      //   String? redirectUrl = response.headers['location']?.first;
      //   print(redirectUrl);
      //   if (redirectUrl != null) {
      //     final redirectResponse = await dio.get(
      //       redirectUrl,
      //       options: Options(
      //         headers: headers,
      //         followRedirects: true,
      //         validateStatus: (status) {
      //           return status! < 500;
      //         },
      //       ),
      //     );
      //
      //     if (redirectResponse.statusCode == 200) {
      //       // Retry adding the book after successful redirect
      //       final retryResponse = await dio.post(
      //         path,
      //         data: bookData,
      //         options: Options(
      //           headers: headers,
      //           followRedirects: false,
      //           maxRedirects: 0,
      //           validateStatus: (status) {
      //             return status! < 500;
      //           },
      //         ),
      //       );
      //
      //       if (retryResponse.statusCode == 200) {
      //         print('Book added successfully: ${retryResponse.data}');
      //       } else {
      //         print('Failed to add book after redirect: ${retryResponse.data}');
      //       }
      //     } else {
      //       print('Redirect login failed: ${redirectResponse.data}');
      //     }
      //   } else {
      //     print('Redirect URL not found in headers.');
      //   }
      // }
      if (response.statusCode == 200) {
        print('Book added successfully: ${response.data}');
      } else {
        print('Unexpected status code: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is LoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false, // Prevent dismissing the dialog
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else if (state is LoadedState) {
            Navigator.of(context).pop();
            AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: "Success",
                    desc: "Book Added successfully",
                    btnOkOnPress: (){})
                .show();
          } else {
            Navigator.of(context).pop();
            AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.topSlide,
                    title: "Error",
                    desc: "Book not Added, there is a problem",
                    btnCancelOnPress: () {})
                .show();
          }
        },
        child: CustomPage(
            page: Padding(
          padding: EdgeInsets.all(8.w),
          child: ListView(
            children: [
              CustomTextFormField(
                textEditingController:
                    BlocProvider.of<AdminCubit>(context).addBookTitle,
                name: "Book title",
              ),
              CustomTextFormField(
                textEditingController:
                    BlocProvider.of<AdminCubit>(context).addBookCategories,
                name: "Book categories",
              ),
              CustomTextFormField(
                textEditingController:
                    BlocProvider.of<AdminCubit>(context).addBookAuthors,
                name: "Book authors",
              ),
              CustomTextFormField(
                textEditingController:
                    BlocProvider.of<AdminCubit>(context).addBookDescription,
                name: "Book description",
              ),
              CustomTextFormField(
                textEditingController:
                    BlocProvider.of<AdminCubit>(context).addBookPublishYear,
                name: "Book published year",
              ),
              CustomTextFormField(
                textEditingController:
                    BlocProvider.of<AdminCubit>(context).addBookAverageRating,
                name: "Book average rating",
              ),
              CustomTextFormField(
                textEditingController:
                    BlocProvider.of<AdminCubit>(context).addBookRatingCount,
                name: "Book ratings count",
              ),
              CustomTextFormField(
                textEditingController:
                    BlocProvider.of<AdminCubit>(context).addBookNumPage,
                name: "num page",
              ),
              CustomTextFormField(
                textEditingController:
                    BlocProvider.of<AdminCubit>(context).addBookURL,
                name: "URL",
              ),
              SizedBox(
                height: 4.h,
              ),
              ElevatedButton(
                onPressed: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  print("herrrrrrrrrrrrrrrrrrrrrrrrrrrrrre");
                  print(prefs.getString("TOKEN"));
                  //getData2();
                  BlocProvider.of<AdminCubit>(context).addBook();
                },
                child: const Text("Add Book"),
              ),
            ],
          ),
        )));
  }
}
