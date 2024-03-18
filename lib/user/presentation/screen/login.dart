import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:sizer/sizer.dart';

import '../../../core/router.dart';
import '../component/reusable_widget.dart';
import '../controller/auth_cubit/auth_cubit.dart';

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
          Container(
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
                  ReusableText(text: 'Login'),
                  SizedBox(height: 100),
                  ReusableTextField(
                    textEditingController: BlocProvider.of<AuthCubit>(context).fName,
                    hintText: 'Email Address',
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  ReusableTextField(
                    textEditingController: BlocProvider.of<AuthCubit>(context).fName,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 50),
                  ReusableButton(
                    onPressed: null,
                    text: "Login",
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, Routers.register);
                            },
                            child: const Text(
                              "Signup",
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
