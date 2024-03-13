import 'package:flutter/material.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:sizer/sizer.dart';

class BookImage extends StatelessWidget {
  BookImage(
      {super.key,

        required this.imagePath});


  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0.w),
      child: Container(
        height: 26.h,
        width: 39.9.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image:
          DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 3.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 3.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
