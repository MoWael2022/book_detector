import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/router.dart';
import '../../../generated/l10n.dart';
import 'drawer_component.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.home]!,
        // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.profile]!,
        // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.detect]!,
        // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.settings]!,
        // BlocProvider.of<AppCubit>(context).pages[DrawerComponentName.aboutUs]!,

        DrawerComponent(
          pageName: S.of(context).home,
          iconData: Icons.home_outlined,
          page: Routers.home,
        ),
        DrawerComponent(
          pageName: S.of(context).categories,
          iconData: Icons.category,
          page: Routers.categories,
        ),
        DrawerComponent(
            pageName: S.of(context).profile,
            iconData: Icons.person_2_outlined,
            page: Routers.profile),
        DrawerComponent(
            pageName: S.of(context).detectBook,
            iconData: Icons.camera_alt_outlined,
            page: Routers.bookDetection),
        DrawerComponent(
            pageName: "Chat Bot",
            iconData: FontAwesomeIcons.robot,
            page: Routers.chatBot),
        DrawerComponent(
            pageName: S.of(context).setting,
            iconData: Icons.settings_outlined,
            page: Routers.settings),
        DrawerComponent(
            pageName: S.of(context).aboutUs,
            iconData: Icons.info_outline_rounded,
            page: Routers.profile),
      ],
    );
  }
}
