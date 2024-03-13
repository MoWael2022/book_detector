import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/enums.dart';

import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:khaltabita/user/presentation/controller/app_state.dart';
import 'package:sizer/sizer.dart';

class DrawerComponent extends StatelessWidget {
  DrawerComponent(
      {super.key,
      required this.pageName,
      required this.iconData,
      required this.iconSize,
      required this.pageChange,
      required this.nameSize});

  String pageName;
  IconData iconData;
  double iconSize;

  double nameSize;
  DrawerComponentName pageChange;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            ListTile(
              onTap: () {

              },
              leading: Icon(
                iconData,
                size: iconSize,
                color: ColorManager.white,
              ),
              title: Text(
                pageName,
                style: TextStyle(color: ColorManager.white, fontSize: nameSize),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        );
      },
      listener: (context, state) {},
    );
  }
}
