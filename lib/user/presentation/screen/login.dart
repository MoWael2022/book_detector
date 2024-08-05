import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khaltabita/core/global_resources/functions.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../core/router.dart';
import '../component/dialogs_component.dart';
import '../component/reusable_widget.dart';
import '../controller/app_cubit.dart';
import '../controller/app_state.dart';
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

  Future<void> _navigateAfterLogin(BuildContext context) async {
    Completer<void> fetchCompleter = Completer<void>();
    Timer timer = Timer(const Duration(seconds: 15), () async {
      bool hasConnection = await Functions.hasInternetConnection();
      if (!hasConnection) {
        if (mounted) {
          Dialogs.errorAwesomeDialog(context, "No Internet Connection");
        }
      }
    });

    await BlocProvider.of<AppCubit>(context).fetchData();
    await BlocProvider.of<AppCubit>(context).getAllBooksFuture();

    if (mounted) {
      Navigator.of(context).pushNamed(Routers.home);
    }

    fetchCompleter.complete();
    timer.cancel(); // Cancel the timer if the fetch completes in time
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BlocListener<AppCubit, AppState>(
            listener: (context, state) {
              if (state is ConnectivityLoading) {
                Dialogs.loadingAwesomeDialog(context);
              } else if (state is ConnectivityFailure) {
                Dialogs.errorAwesomeDialog(context, state.message.toString());
              } else if (state is ConnectivitySuccess) {
                Dialogs.successAwesomeDialog(context);
              }
            },
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) async {
                if (state is LoadingLoginState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // Prevent dismissing the dialog
                    builder: (BuildContext context) {
                      return Functions.loadingLottie();
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
                } else if (state is LoadedLoginState) {
                  BlocProvider.of<AuthCubit>(context).isAdminFunc();
                  SharedPreferences prefs = await SharedPreferences
                      .getInstance();
                  prefs.setBool("isSignIn", true);
                  prefs.setString("firstName", state.outputData.fName);
                  prefs.setString("lastName", state.outputData.lName);
                  prefs.setString("email", state.outputData.email);
                  prefs.setString('TOKEN', state.outputData.token);

                  _navigateAfterLogin(context);
                }
              },
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom),
                child: SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Form(
                    key:formKey,
                    child: ListView(
                      children: [
                        Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage(
                                  ImagePathManager.loginCover),
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
                                ReusableText(text: S
                                    .of(context)
                                    .login),
                                const SizedBox(height: 100),
                                ReusableTextField(
                                  validator: (value) {
                                    if (value.isEmpty && value == null) {
                                      return "Please Enter ${S
                                          .of(context)
                                          .EnterEmail}";
                                    }
                                  },
                                  textEditingController:
                                  BlocProvider
                                      .of<AuthCubit>(context)
                                      .emailLogin,
                                  hintText: S
                                      .of(context)
                                      .EnterEmail,
                                  obscureText: false,
                                ),
                                const SizedBox(height: 20),
                                ReusableTextField(
                                  validator: (value) {
                                    if (value.isEmpty && value == null) {
                                      return "Please Enter ${S
                                          .of(context)
                                          .EnterPassword}";
                                    }
                                  },
                                  textEditingController:
                                  BlocProvider
                                      .of<AuthCubit>(context)
                                      .passwordLogin,
                                  hintText: S
                                      .of(context)
                                      .EnterPassword,
                                  obscureText: true,
                                ),
                                const SizedBox(height: 50),
                                ReusableButton(
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      BlocProvider.of<AuthCubit>(context).login();
                                    }

                                    //Navigator.pushNamed(context, Routers.homePage);
                                  },
                                  text: S
                                      .of(context)
                                      .login,
                                ),
                                const SizedBox(height: 20),
                                TextButton(
                                  onPressed: null,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S
                                            .of(context)
                                            .haveAccount,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(
                                                context, Routers.register);
                                          },
                                          child: Text(
                                            S
                                                .of(context)
                                                .signUp,
                                            style: const TextStyle(
                                              color: Color(0xFFC68D69),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7.h),
                                Text(
                                  S
                                      .of(context)
                                      .anotherAccount,
                                  style: const TextStyle(
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
