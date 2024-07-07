import 'package:flutter/material.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/core/global_resources/string_manager.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/component/scroll_component.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sizer/sizer.dart';

class HamePage extends StatefulWidget {
  const HamePage({super.key});

  @override
  State<HamePage> createState() => _HamePageState();
}

class _HamePageState extends State<HamePage> {
  List<Widget> dataScrollComponent = [
    ScrollComponent(
        textData: StringManager.translateDescription,
        image: ImagePathManager.translateIcon),
    ScrollComponent(
        textData: StringManager.chatBotDescription,
        image: ImagePathManager.robotIcon),
    ScrollComponent(
        textData: StringManager.cameraDescription,
        image: ImagePathManager.cameraIcon),
  ];

  Widget _listBuilder(BuildContext context, int index) {
    if (index == dataScrollComponent.length) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return dataScrollComponent[index];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      page: ListView(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.all(5.0.w),
            child: Text(
              textAlign: TextAlign.center,
              "Discover,Capture, and Explore Books ",
              style: TextStyle(
                  color: ColorManager.titleInHome,
                  fontSize: 9.w,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0.w),
            child: Container(
              decoration: BoxDecoration(
                border: const Border(
                  left: BorderSide(color: ColorManager.titleInHome, width: 2),
                  top: BorderSide(color: ColorManager.titleInHome, width: 2),
                  right: BorderSide(color: ColorManager.titleInHome, width: 2),
                  bottom: BorderSide(color: ColorManager.titleInHome, width: 2),
                ),
                borderRadius: BorderRadius.circular(20),
                color: ColorManager.containerHome,
              ),
              child: Padding(
                padding: EdgeInsets.all(4.0.w),
                child: Text(
                  textAlign: TextAlign.center,
                  "\" Welcome to Book Detector "
                  "Explore Books with Ease! Our app makes "
                  "discovering new books effortless and enjoyable. "
                  "Join us today and start your visual literary journey!\"",
                  style: TextStyle(
                    fontSize: 5.5.w,
                    color: ColorManager.titleInHome,
                  ),
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: LayoutBuilder(
          //     builder: (context,constraint) {
          //       return SizedBox(
          //         height: 30.h,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
                width: 90.w,
                child: ScrollSnapList(
                  itemBuilder: _listBuilder,
                  itemCount: dataScrollComponent.length,
                  itemSize: 90.w,
                  dynamicItemSize: true,
                  onItemFocus: (index) {},
                  onReachEnd: () {},
                ),
              ),
            ],
          ),
          //       );
          //     }
          //   ),
          // )
          //Image.asset(ImagePathManager.robotIcon)
        ],
      ),
    );
  }
}
