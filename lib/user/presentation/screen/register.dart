import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/data/model/user_input_model.dart';
import 'package:khaltabita/user/domin/usecase/register_usecase.dart';
import 'package:khaltabita/user/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:khaltabita/user/presentation/controller/auth_cubit/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/global_resources/functions.dart';
import '../../../core/router.dart';
import '../../../generated/l10n.dart';
import '../component/dialogs_component.dart';
import '../component/reusable_widget.dart';
import 'package:http/http.dart' as http;
import '../controller/app_cubit.dart';
import '../controller/app_state.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppCubit, AppState>(
        listener: (context, state) {
          if (state is ConnectivityLoading) {
            Dialogs.loadingAwesomeDialog(context);
          } else if (state is ConnectivityFailure) {
            Dialogs.errorAwesomeDialog(context, state.message.toString());
          } else if (state is ConnectivitySuccess) {
            Dialogs.successAwesomeDialog(context);
          }
        },
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) async {
                if (state is LoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // Prevent dismissing the dialog
                    builder: (BuildContext context) {
                      return Functions.loadingLottie();
                    },
                  );
                } else if (state is ErrorState) {
                  Navigator.pop(context);
                  Dialogs.errorAwesomeDialog(
                      context, state.failureMessage.toString());
                } else if (state is LoadedState) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("isSignIn", true);
                  prefs.setString("firstName", state.data.fName);
                  prefs.setString("lastName", state.data.lName);
                  prefs.setString("email", state.data.email);
                  Navigator.pushNamed(context, Routers.home);
                }
              },
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      Stack(
                        children: [
                          Form(
                            key: formKey,
                            child: Container(
                              height: 125.h,
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
                            ),
                          ),
                          Center(
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 7.h),
                                ReusableText(text: S.of(context).signUp),
                                const SizedBox(height: 50),
                                ReusableTextField(
                                  validator: (value) {
                                    if (value.isEmpty && value == null) {
                                      return "Please Enter ${S.of(context).firstName}";
                                    }
                                  },
                                  textEditingController:
                                      BlocProvider.of<AuthCubit>(context).fName,
                                  hintText: S.of(context).firstName,
                                  obscureText: false,
                                ),
                                const SizedBox(height: 10),
                                ReusableTextField(
                                  validator: (value) {
                                    if (value.isEmpty && value == null) {
                                      return "Please Enter ${S.of(context).lastName}";
                                    }
                                  },
                                  textEditingController:
                                      BlocProvider.of<AuthCubit>(context).lName,
                                  hintText: S.of(context).lastName,
                                  obscureText: false,
                                ),
                                const SizedBox(height: 10),
                                ReusableTextField(
                                  validator: (value) {
                                    if (value.isEmpty && value == null) {
                                      return "Please Enter ${S.of(context).Email}";
                                    }
                                  },
                                  textEditingController:
                                      BlocProvider.of<AuthCubit>(context).email,
                                  hintText: S.of(context).Email,
                                  obscureText: false,
                                ),
                                const SizedBox(height: 10),
                                ReusableTextField(
                                  validator: (value) {
                                    if (value.isEmpty && value == null) {
                                      return "Please Enter ${S.of(context).password}";
                                    } else if (value.length <= 7) {
                                      return "the length must be longer than 7";
                                    }
                                  },
                                  textEditingController:
                                      BlocProvider.of<AuthCubit>(context)
                                          .password,
                                  hintText: S.of(context).password,
                                  obscureText: true,
                                ),
                                const SizedBox(height: 10),
                                ReusableTextField(
                                  validator: (value) {
                                    if (value.isEmpty && value == null) {
                                      return "Please Enter ${S.of(context).confirmPassword}";
                                    }
                                  },
                                  textEditingController:
                                      BlocProvider.of<AuthCubit>(context)
                                          .confirmPassword,
                                  hintText: S.of(context).confirmPassword,
                                  obscureText: true,
                                ),
                                const SizedBox(height: 40),
                                ReusableButton(
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      BlocProvider.of<AuthCubit>(context)
                                          .register();
                                    }
                                    //Navigator.pushNamed(context, Routers.homePage);
                                  },
                                  text: S.of(context).signUp,
                                ),
                                SizedBox(height: 1.h),
                                TextButton(
                                  onPressed: null,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).alreadyHaveAccount,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, Routers.login);
                                        },
                                        child: Text(
                                          S.of(context).login,
                                          style: const TextStyle(
                                            color: Color(0xFFC68D69),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  S.of(context).anotherAccount,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// @override
// void dispose() {
//   _emailController.dispose();
//   _passwordController.dispose();
//   super.dispose();
// }
}
