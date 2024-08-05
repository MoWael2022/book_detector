import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khaltabita/core/enums.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/user/presentation/component/drawer.dart';
import 'package:khaltabita/user/presentation/component/drawer_component.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:khaltabita/user/presentation/controller/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router.dart';
import '../../../generated/l10n.dart';
import '../controller/auth_cubit/auth_cubit.dart';
import '../controller/auth_cubit/auth_state.dart';
import 'dialogs_component.dart';

class CustomPage extends StatefulWidget {
  CustomPage({this.color = ColorManager.backgroundColor, super.key, required this.page});

  Widget page;
  Color? color ;

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  String? name;

  Future<String>? data;

  Future<String> getNameUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("firstName")! ?? "User";
  }

  @override
  void initState() {
    super.initState();
    data = getNameUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if(state is ConnectivityLoading){
            Dialogs.loadingAwesomeDialog(context);
          }else if (state is ConnectivityFailure){
            Dialogs.errorAwesomeDialog(context, state.message.toString());
          }else if(state is ConnectivitySuccess){
            Dialogs.successAwesomeDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: widget.color,
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
                child: FutureBuilder<String>(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage("assets/test.png"),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              "Loading...",
                              style: TextStyle(
                                  color: ColorManager.white, fontSize: 4.w),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage("assets/test.png"),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              "Error",
                              style: TextStyle(
                                  color: ColorManager.white, fontSize: 4.w),
                            ),
                          ],
                        );
                      } else {
                        return Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage("assets/test.png"),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              snapshot.data!,
                              style: TextStyle(
                                  color: ColorManager.white, fontSize: 4.w),
                            ),
                          ],
                        );
                      }
                    }),
              ),
            ),
            endDrawer: Drawer(
              backgroundColor: ColorManager.drawerColor.withOpacity(.5),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                  ),
                  side: BorderSide(color: ColorManager.white)),
              child: BlocBuilder<AuthCubit,AuthState>(
                builder: (context ,state){
                  if(state is AdminMode){
                    return ListView(
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        DrawerComponent(
                          pageName: S.of(context).manage,
                          iconData: Icons.manage_accounts,
                          page: Routers.managePage,
                        ),
                        const DrawerWidget(),

                      ],
                    );
                  }else {
                    return ListView(
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        const DrawerWidget(),
                      ],
                    );
                  }
                },
              )
            ),
            body: widget.page,
          );
        });
  }
}
