sealed class AuthEx implements Exception {
  final String message;

  AuthEx({required this.message});
}

final class AuthErrorEx extends AuthEx {
  AuthErrorEx({required String message}) : super(message: message);
}

final class AuthUnauthorizedEx extends AuthEx {
  AuthUnauthorizedEx() : super(message: '');
}
