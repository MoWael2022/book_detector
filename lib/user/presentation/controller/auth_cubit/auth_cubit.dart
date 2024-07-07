import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/router.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/data/model/user_input_model.dart';
import 'package:khaltabita/user/domin/usecase/login_usecase.dart';
import 'package:khaltabita/user/domin/usecase/register_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/Authontication_exception.dart';
import '../../../../core/global_resources/constants.dart';
import '../../../domin/entites/User.dart';
import '../../../domin/entites/input_login_data.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitAuthState()) {
    _loadAdminData();
  }

  TextEditingController email = TextEditingController();

  TextEditingController fName = TextEditingController();

  TextEditingController lName = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  TextEditingController passwordLogin = TextEditingController();

  TextEditingController emailLogin = TextEditingController();

  User? currentUser;
  bool? isAdmin;

  _loadAdminData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdmin = prefs.getBool("isAdmin") ?? false;
    if(isAdmin!){
      emit(AdminMode());
    }else {
      emit(UserMode());
    }
    //emit(SaveMode(isAdmin!));
  }

  void isAdminFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentUser!.id == AppConstants.adminId) {
      prefs.setBool("isAdmin", true);
      emit(AdminMode());
    } else {
      prefs.setBool("isAdmin", false);
      emit(UserMode());
    }
  }

  void register() async {
    emit(LoadingState());
    // Emit LoadingState before starting registration
    try {
      final result = instance<RegisterUsecase>();

      final data = await result.call(UserInputModel(
        email: email.text,
        confirmPassword: confirmPassword.text,
        fName: fName.text,
        lName: lName.text,
        password: password.text,
      ));
      data.fold(
        (failure) {
          // Emit ErrorState if registration fails
          emit(ErrorState(failure.messageError));
        },
        (user) {
          currentUser = user;
          //Navigator.pushNamed(context, Routers.homePage);
          emit(LoadedState(user)); // Emit LoadedState if registration succeeds
        },
      );
    } catch (e) {
      emit(ErrorLoginState("Invalid email or password"));

      //emit(ErrorState(e.toString()));
    }
  }


  void login() async {
    emit(LoadingLoginState());
    try {
      final result = instance<LoginUsecase>();

      final data = await result.call(InputLoginData(
        email: emailLogin.text,
        password: passwordLogin.text,
      ));
      data.fold(
        (failure) {
          // Emit ErrorState if registration fails
          emit(ErrorLoginState(failure.messageError));
        },
        (user) {
          print(user);
          currentUser = user;
          //Navigator.pushNamed(context, Routers.homePage);
          emit(LoadedLoginState(
              user)); // Emit LoadedState if registration succeeds
        },
      );
    } catch (e) {
      emit(ErrorLoginState("Invalid email or password"));

      //emit(ErrorLoginState(e.toString()));
    }
  }
}
