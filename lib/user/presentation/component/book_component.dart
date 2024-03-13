import 'package:flutter/material.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:sizer/sizer.dart';

class BookComponent extends StatelessWidget {
  BookComponent(
      {super.key,
        required this.bookName,
        required this.rate,
        required this.imagePath});

  String bookName;
  String rate;
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
          DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.fill),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 3.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff693712), Colors.transparent])),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 3.w,
              ),
              Container(
                width: 20.w,
                child: Text(
                  bookName,
                  style: TextStyle(
                    color: ColorManager.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 5.w,
                  ),
                ),
              ),
              Container(
                width: 16.9.w,
                child: Text(
                  "⭐$rate",
                  style: TextStyle(
                    color: ColorManager.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 4.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
