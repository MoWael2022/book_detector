import '../../../domin/entites/User.dart';

abstract class AuthState {}

class InitAuthState extends AuthState {}

class LoadingState extends AuthState {}

class LoadedState extends AuthState {
  User data;

  LoadedState(this.data);
}

class ErrorState extends AuthState {}
