import 'package:flutter/cupertino.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/core/global_resources/string_manager.dart';
import 'package:sizer/sizer.dart';

class ScrollComponent extends StatelessWidget {
  ScrollComponent({super.key, required this.textData, required this.image});

  String textData;
  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(ImagePathManager.scrollComponent),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 1.w,
            top: 1.h,
            child: Image.asset(image),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                textData,
                style: TextStyle(
                    color: ColorManager.titleInHome,
                    fontSize: 5.w,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
