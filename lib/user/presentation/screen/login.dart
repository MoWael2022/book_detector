import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/router.dart';
import '../component/reusable_widget.dart';
import '../controller/auth_cubit/auth_cubit.dart';
import '../controller/auth_cubit/auth_state.dart';

//user name mowael@gmail.com
//password 753210Mo@123

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) async {
              if (state is LoadingLoginState) {
                showDialog(
                  context: context,
                  barrierDismissible: false, // Prevent dismissing the dialog
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else if (state is ErrorLoginState) {
                Navigator.pop(context);
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.topSlide,
                        title: "Error",
                        desc: state.failureMessage.toString(),
                        btnCancelOnPress: () {})
                    .show();
                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (BuildContext context) {
                //     return AlertDialog(
                //       title: Text('Error'),
                //       content: Text(state.failureMessage.toString()),
                //       // Display the error message in the dialog
                //       actions: [
                //         TextButton(
                //           onPressed: () {
                //             Navigator.of(context).pop(); // Close the dialog
                //           },
                //           child: Text('OK'),
                //         ),
                //       ],
                //     );
                //   },
                // );
              } else if (state is LoadedLoginState) {
                BlocProvider.of<AuthCubit>(context).isAdminFunc();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isSignIn", true);
                prefs.setString("firstName", state.outputData.fName);
                prefs.setString("lastName", state.outputData.lName);
                prefs.setString("email", state.outputData.email);
                prefs.setString('TOKEN', state.outputData.token);

                Navigator.of(context).pushNamed(Routers.home);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(ImagePathManager.loginCover),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReusableText(text: S.of(context).login),
                            SizedBox(height: 100),
                            ReusableTextField(
                              textEditingController:
                                  BlocProvider.of<AuthCubit>(context)
                                      .emailLogin,
                              hintText: S.of(context).EnterEmail,
                              obscureText: false,
                            ),
                            SizedBox(height: 20),
                            ReusableTextField(
                              textEditingController:
                                  BlocProvider.of<AuthCubit>(context)
                                      .passwordLogin,
                              hintText: S.of(context).EnterPassword,
                              obscureText: true,
                            ),
                            SizedBox(height: 50),
                            ReusableButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context).login();
                                //Navigator.pushNamed(context, Routers.homePage);
                              },
                              text: S.of(context).login,
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              onPressed: null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).haveAccount,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, Routers.register);
                                      },
                                      child: Text(
                                        S.of(context).signUp,
                                        style: const TextStyle(
                                          color: Color(0xFFC68D69),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(height: 7.h),
                            Text(
                              S.of(context).anotherAccount,
                              style: TextStyle(
                                color: Color(0xFFC68D69),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.google,
                                  size: 10.w, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
