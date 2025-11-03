// bloc/auth/auth_state.dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthInitializing extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userId;
  final String userName;
  final String userEmail;
  final bool rememberMe;

  AuthAuthenticated({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.rememberMe = false,
  });
}

class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class ForgotPasswordSent extends AuthState {
  final String message;

  ForgotPasswordSent(this.message);
}

class PasswordResetSuccess extends AuthState {
  final String message;

  PasswordResetSuccess(this.message);
}