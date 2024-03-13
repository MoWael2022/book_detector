import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/data/data_source/base_remote_data_source.dart';
import 'package:khaltabita/user/data/data_source/remote_data_source.dart';
import 'package:khaltabita/user/data/repository/user_repository.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_book_categories.dart';
import 'package:khaltabita/user/presentation/component/category_component.dart';
import 'package:sizer/sizer.dart';
import 'package:get_it/get_it.dart';

import '../../../core/error/category_exceptions.dart';
import '../../../core/global_resources/constants.dart';
import '../../data/model/categories_model.dart';
import '../component/drawer_component_selected.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookDescription extends StatefulWidget {
  const BookDescription({super.key});

  @override
  State<BookDescription> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  final result = instance<GetBookCategoriesUseCase>();

  getData() async {
    final r = instance<GetBookCategoriesUseCase>();
    final data = await r.call(const NoParameter());

    print(data.length());
    for (int i = 0; i < data.length(); i++) {
      final d = data.fold((l) => l.messageError, (r) => r.length);
      print("----------------------> $d");
    }

    // print(result.call(const NoParameter()));
    //return result;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 40.h,
            flexibleSpace: Container(
              //height: 35.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/book test.png"),
                  fit: BoxFit.cover,
                  opacity: .9,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 10.h,
                    child: BookImage(imagePath: "assets/book test.png"),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ListTile(
                        title: Text('item ${1 + index}'),
                      );
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
        // child: PreferredSize(
        //   preferredSize: Size.fromHeight(40.h),
        //   child: AppBar(
        //     flexibleSpace: Container(
        //       height: 35.h,
        //       decoration: const BoxDecoration(
        //         borderRadius: BorderRadius.only(
        //           bottomRight: Radius.circular(25),
        //           bottomLeft: Radius.circular(25),
        //         ),
        //         image: DecorationImage(
        //           image: AssetImage("assets/book test.png"),
        //           fit: BoxFit.cover,
        //           opacity: .9,
        //         ),
        //       ),
        //       child: Stack(
        //         clipBehavior: Clip.none,
        //         alignment: Alignment.bottomCenter,
        //         children: [
        //           Positioned(
        //               top: 10.h,
        //               child: BookImage(imagePath: "assets/book test.png")),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
