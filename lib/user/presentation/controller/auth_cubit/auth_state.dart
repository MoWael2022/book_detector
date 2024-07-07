import '../../../domin/entites/User.dart';
import '../../../domin/entites/output_data.dart';

abstract class AuthState {}

class InitAuthState extends AuthState {}

class LoadingState extends AuthState {}

class LoadedState extends AuthState {
  User data;

  LoadedState(this.data);
}

class LoadedLoginState extends AuthState {
  User outputData;

  LoadedLoginState(this.outputData);
}

class ErrorState extends AuthState {
  String failureMessage;

  ErrorState(this.failureMessage);
}


class ErrorLoginState  extends AuthState {
String failureMessage;

ErrorLoginState(this.failureMessage);
}

class LoadingLoginState extends AuthState {}

class SaveMode extends AuthState{
  bool adminValue ;
  SaveMode(this.adminValue);
}

class AdminMode extends AuthState{}

class UserMode extends AuthState{}