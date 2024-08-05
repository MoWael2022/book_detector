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
import '../../../core/global_resources/functions.dart';

class ManageBook extends StatefulWidget {
  const ManageBook({super.key});

  @override
  State<ManageBook> createState() => _ManageBookState();
}

class _ManageBookState extends State<ManageBook> {


  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is LoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false, // Prevent dismissing the dialog
              builder: (BuildContext context) {
                return Functions.loadingLottie();
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
          }
          // else {
          //   Navigator.of(context).pop();
          //   AwesomeDialog(
          //       context: context,
          //       dialogType: DialogType.error,
          //       animType: AnimType.topSlide,
          //       title: "Error",
          //       desc: "Book not Added, there is a problem",
          //       btnCancelOnPress: () {})
          //       .show();
          // }
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
