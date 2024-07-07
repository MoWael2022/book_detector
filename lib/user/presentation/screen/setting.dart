import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/router.dart';
import '../controller/app_cubit.dart';
import '../controller/app_state.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          BlocProvider.of<AppCubit>(context).fetchData();
        }
      },
      child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        return CustomPage(
          page: ListView(
            children: [
              SizedBox(
                height: 2.h,
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.language),
                title: const Text("Language"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text("Language"),
                          children: [
                            ListTile(
                              title: const Text("Arabic"),
                              onTap: () {
                                BlocProvider.of<AppCubit>(context)
                                    .changeLanguage('ar');
                              },
                            ),
                            ListTile(
                              title: const Text("English"),
                              onTap: () {
                                BlocProvider.of<AppCubit>(context)
                                    .changeLanguage('en');
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
              ListTile(
                leading:const Icon(Icons.logout),
                title:const Text("Log out"),
                onTap: ()async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool("isSignIn", false);
                  prefs.remove("email");
                  prefs.remove("lastName");
                  prefs.remove("firstName");
                  prefs.remove("language");
                  Navigator.of(context).pushReplacementNamed(Routers.login);
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
