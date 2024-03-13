import 'package:flutter/material.dart';
import 'package:khaltabita/core/enums.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/user/presentation/component/drawer_component.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:khaltabita/user/presentation/controller/app_state.dart';
import 'package:sizer/sizer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPage extends StatelessWidget {
  CustomPage({super.key, required this.page});

  Widget page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorManager.appbarColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.menu),
                color: ColorManager.white,
              );
            },
          ),
        ],
        leadingWidth: 50.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/test.png"),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "Wael",
                style: TextStyle(color: ColorManager.white, fontSize: 4.w),
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: ColorManager.drawerColor.withOpacity(.5),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
            ),
            side: BorderSide(color: ColorManager.white)),
        child: BlocConsumer<AppCubit, AppState>(
          builder: (context, state) {
            return ListView(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.home]!,
                // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.profile]!,
                // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.detect]!,
                // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.settings]!,
                // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.aboutUs]!,


                // DrawerComponent(pageName: "Home", iconData: Icons.home_outlined),
                // DrawerComponent(
                //     pageName: "Profile", iconData: Icons.person_2_outlined),
                // DrawerComponent(
                //     pageName: "Detect book", iconData: Icons.camera_alt_outlined),
                // DrawerComponent(pageName: "Setting", iconData: Icons.settings_outlined),
                // DrawerComponent(pageName: "About Us", iconData: Icons.info_outline_rounded),
              ],
            );
          },
          listener: (context, state) {},
        ),
      ),
      body: page,
    );
  }
}
