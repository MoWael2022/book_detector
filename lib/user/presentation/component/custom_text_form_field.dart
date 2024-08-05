import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/user/presentation/component/search_data.dart';
import 'package:sizer/sizer.dart';


import '../../../core/global_resources/color_manager.dart';
import '../../../core/router.dart';
import '../controller/app_cubit.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(
          left: 8.0.w, right: 8.0.w, top: 3.h, bottom: 1.h),
      child: SizedBox(
        height: 6.h,
        child: TextFormField(
          onTap: (){
            showSearch(context: context, delegate: CustomSearch());
            BlocProvider.of<AppCubit>(context).fetchData();
            //print( BlocProvider.of<AppCubit>(context).booksCategories.length);
          },
          decoration: InputDecoration(
            hoverColor: ColorManager.textFormFieldColr,
            hintText: "Search..",
            hintStyle: const TextStyle(
              color: ColorManager.textFormFieldColr,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                  Navigator.pushNamed(context, Routers.bookDetection);
              },
              icon: Icon(
                Icons.camera_alt_outlined,
                color: ColorManager.textFormFieldColr,
                size: 8.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: ColorManager.textFormFieldColr),
              borderRadius: BorderRadius.circular(25),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: ColorManager.textFormFieldColr),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: ColorManager.textFormFieldColr),
              borderRadius: BorderRadius.circular(25),
            ),
            border: OutlineInputBorder(
              borderSide:
              const BorderSide(color: ColorManager.textFormFieldColr),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}
