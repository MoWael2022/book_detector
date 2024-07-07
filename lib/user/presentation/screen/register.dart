import 'package:dio/dio.dart';
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

import '../../../core/global_resources/constants.dart';
import '../../../core/router.dart';
import '../../../generated/l10n.dart';
import '../component/reusable_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  getDataClean() async {
    String dd = "";
    final result = instance<RegisterUsecase>();
    final data = await result.call(UserInputModel(
        email: "hohohhoh@gmail.com",
        confirmPassword: "9876543mM@",
        fName: "hoho",
        lName: "momo",
        password: "9876543mM@"));
    print(data.fold((l) {}, (r) => r.email));
  }

  getData() async {
    String path = "https://demobookdetector.azurewebsites.net/register";
    Map<String, String> formData = {
      "Email": "mohamed987@gmail.com",
      "Fname": "Mohamedddd",
      "Lname": "momooooo",
      "Password": "123456654321Ae@",
      "ConfirmPassword": "123456654321Ae@",
    };

    try {
      final response = await http.post(Uri.parse(path), body: formData);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400) {
        print('Bad request: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      print('Http error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    getDataClean();
    //getData();
  }

  //final state = BlocProvider.of<AuthCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) async{
              if (state is LoadingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false, // Prevent dismissing the dialog
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else if (state is ErrorState) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(S.of(context).error),
                      content: Text(state.failureMessage.toString()),
                      // Display the error message in the dialog
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text(S.of(context).ok),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is LoadedState) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
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
                        Container(
                          height: 125.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  const AssetImage(ImagePathManager.loginCover),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken,
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
                              SizedBox(height: 50),
                              ReusableTextField(
                                textEditingController:
                                    BlocProvider.of<AuthCubit>(context).fName,
                                hintText: S.of(context).firstName,
                                obscureText: false,
                              ),
                              SizedBox(height: 10),
                              ReusableTextField(
                                textEditingController:
                                    BlocProvider.of<AuthCubit>(context).lName,
                                hintText: S.of(context).lastName,
                                obscureText: false,
                              ),
                              SizedBox(height: 10),
                              ReusableTextField(
                                textEditingController:
                                    BlocProvider.of<AuthCubit>(context).email,
                                hintText: S.of(context).Email,
                                obscureText: false,
                              ),
                              SizedBox(height: 10),
                              ReusableTextField(
                                textEditingController:
                                    BlocProvider.of<AuthCubit>(context)
                                        .password,
                                hintText: S.of(context).password,
                                obscureText: true,
                              ),
                              SizedBox(height: 10),
                              ReusableTextField(
                                textEditingController:
                                    BlocProvider.of<AuthCubit>(context)
                                        .confirmPassword,
                                hintText: S.of(context).confirmPassword,
                                obscureText: true,
                              ),
                              SizedBox(height: 40),
                              ReusableButton(
                                onPressed: () {
                                  BlocProvider.of<AuthCubit>(context)
                                      .register();
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
                                      style:const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, Routers.login);
                                      },
                                      child:  Text(
                                        S.of(context).login,
                                        style:const TextStyle(
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
                                style:const TextStyle(
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
    );
  }

// @override
// void dispose() {
//   _emailController.dispose();
//   _passwordController.dispose();
//   super.dispose();
// }
}
