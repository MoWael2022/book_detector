import 'error_model.dart';

class AuthenticationException implements Exception {
  ErrorModel errorModel;

  AuthenticationException({required this.errorModel});
}
