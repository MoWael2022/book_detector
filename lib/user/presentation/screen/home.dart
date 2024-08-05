import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/core/global_resources/string_manager.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/component/dialogs_component.dart';
import 'package:khaltabita/user/presentation/component/scroll_component.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:khaltabita/user/presentation/controller/app_state.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sizer/sizer.dart';

import '../component/book_component.dart';

class HamePage extends StatefulWidget {
  const HamePage({super.key});

  @override
  State<HamePage> createState() => _HamePageState();
}

class _HamePageState extends State<HamePage> {
  late final result;
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
              Padding(
                padding:EdgeInsets.only(left: 6.w,right: 6.w,top: 2.h,bottom: .3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categories",style: TextStyle(fontSize: 6.w,fontWeight: FontWeight.bold)),
                    TextButton(onPressed: (){},child:const Text("View all categories"),),
                  ],
                ),
              ),
              Padding(
                padding:EdgeInsets.only(left: 4.w,right: 4.w),
                child: ListView(
                  physics:
                  const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 27.h,
                      width: 45.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount:10,
                        itemBuilder: (context, i) {
                          return BookComponent(
                            bookName: BlocProvider.of<AppCubit>(
                                context)
                                .categories[i]
                                .categoryName,
                            rate: BlocProvider.of<AppCubit>(
                                context)
                                .allBook[i]
                                .averageRating,
                            imagePath: BlocProvider.of<AppCubit>(
                                context)
                                .allBook[i]
                                .urlImage,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:EdgeInsets.only(left: 6.w,right: 6.w,top: 2.h,bottom: .3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Books",style: TextStyle(fontSize: 6.w,fontWeight: FontWeight.bold)),
                    TextButton(onPressed: (){},child:const Text("View all Books"),),
                  ],
                ),
              ),
              Padding(
                padding:EdgeInsets.only(left: 4.w,right: 4.w),
                child: ListView(
                  physics:
                  const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 27.h,
                      width: 45.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount:10,
                        itemBuilder: (context, i) {
                          return BookComponent(
                            bookName: BlocProvider.of<AppCubit>(
                                context)
                                .allBook[i]
                                .title,
                            rate: BlocProvider.of<AppCubit>(
                                context)
                                .allBook[i]
                                .averageRating,
                            imagePath: BlocProvider.of<AppCubit>(
                                context)
                                .allBook[i]
                                .urlImage,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
