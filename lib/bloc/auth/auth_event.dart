// bloc/auth/auth_event.dart
abstract class AuthEvent {}

class InitializeAuth extends AuthEvent {}

class SignInUser extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  SignInUser({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });
}

class SignUpUser extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpUser({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LogoutUser extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class ForgotPassword extends AuthEvent {
  final String email;

  ForgotPassword(this.email);
}

class ResetPassword extends AuthEvent {
  final String code;
  final String newPassword;

  ResetPassword({
    required this.code,
    required this.newPassword,
  });
}