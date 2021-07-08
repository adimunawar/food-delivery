part of 'models.dart';

class ApiReturnValue<T> {
  final T value;
  final String message;

  ApiReturnValue({this.message, this.value});
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}
