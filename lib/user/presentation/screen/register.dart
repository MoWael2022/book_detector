import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/data/model/user_input_model.dart';
import 'package:khaltabita/user/domin/usecase/register_usecase.dart';
import 'package:khaltabita/user/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:khaltabita/user/presentation/controller/auth_cubit/auth_state.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/constants.dart';
import '../../../core/router.dart';
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
    String dd ="";
    final result = instance<RegisterUsecase>();
    final data = await result.call(UserInputModel(
        email: "hohohhoh@gmail.com",
        confirmPassword: "9876543mM@",
        fName: "hoho",
        lName: "momo",
        password: "9876543mM@"));
    print(data.fold((l) {

    }, (r) => r.email));

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
          BlocListener<AuthCubit,AuthState>(
            listener: (context , state){
              if(state is LoadingState){
                showDialog(
                  context: context,
                  barrierDismissible: false, // Prevent dismissing the dialog
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }
            },
            child: Container(
              height: 100.h,
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
                    ReusableText(text: 'Signup'),
                    SizedBox(height: 50),
                    ReusableTextField(
                      textEditingController: BlocProvider.of<AuthCubit>(context).fName,
                      hintText: 'first Name',
                      obscureText: false,
                    ),
                    SizedBox(height: 10),
                    ReusableTextField(
                      textEditingController: BlocProvider.of<AuthCubit>(context).lName,
                      hintText: 'Last Name',
                      obscureText: false,
                    ),
                    SizedBox(height: 10),
                    ReusableTextField(
                      textEditingController: BlocProvider.of<AuthCubit>(context).email,
                      hintText: 'Email Address',
                      obscureText: false,
                    ),
                    SizedBox(height: 10),
                    ReusableTextField(
                      textEditingController: BlocProvider.of<AuthCubit>(context).password,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    ReusableTextField(
                      textEditingController: BlocProvider.of<AuthCubit>(context).confirmPassword,
                      hintText: 'Confirm Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 40),
                    ReusableButton(
                      onPressed: (){
                        BlocProvider.of<AuthCubit>(context).register(context);
                      },
                      text: "Signup",
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account !',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routers.login);
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Color(0xFFC68D69),
                                ),
                              ))
                        ],
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

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }
}
