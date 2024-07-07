import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/data/model/output_data_model.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:khaltabita/user/domin/usecase/get_all_book_in_one_category_usecase.dart';

import 'package:khaltabita/user/presentation/component/category_component.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/component/custom_text_form_field.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../../core/global_resources/constants.dart';
import '../controller/app_cubit.dart';
import '../controller/app_state.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // getData() async {
  //   String url = AppConstants.loginPath;
  //   Dio dio = Dio();
  //   dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
  //
  //   FormData formData = FormData.fromMap({
  //     'Email': "mo9877@gmail.com",
  //     'password': "123456654321Ae@",
  //     // Add any additional fields if needed
  //   });
  //
  //   try {
  //     Response response = await dio.get(url, data: formData);
  //     if (response.statusCode == 200) {
  //       print(response.data);
  //       final data = OutputDataModel.fromJson(response.data);
  //       print(data.userData.email);
  //
  //       // You can handle the response here
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }


  @override
  void initState() {
    super.initState();
    //getData();
    //BlocProvider.of<AppCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      if (state is LoadingCategoryDataState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LoadedCategoryDataState) {
        return CustomPage(
          page: ListView(
            children: [
              const CustomTextFormField(),
              Padding(
                padding: EdgeInsets.all(5.w),
                child: Center(
                  child:

                      //print(state.data[0].categoryName);
                      Wrap(
                    children: state.data.map((category) {
                      return CategoryComponent(
                        bookName: category.categoryName,
                        rate: "4.5",
                        imagePath: "assets/book test.png",
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        );
      } else if (state is ErrorCategoryDataState) {
        return Text(state.failure.messageError);
      } else {
        return const Center(
          child: Text("error"),
        );
      }
    });
  }
}
