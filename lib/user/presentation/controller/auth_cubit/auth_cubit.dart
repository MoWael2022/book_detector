import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/data/model/user_input_model.dart';
import 'package:khaltabita/user/domin/usecase/register_usecase.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitAuthState());

  TextEditingController email = TextEditingController();

  TextEditingController fName = TextEditingController();

  TextEditingController lName = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  void register(BuildContext context) async {
    emit(LoadingState()); // Emit LoadingState before starting registration
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
        emit(ErrorState()); // Emit ErrorState if registration fails
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(failure.toString()), // Display the error message in the dialog
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
          (user) {
        emit(LoadedState(user)); // Emit LoadedState if registration succeeds
      },
    );
  }
}
