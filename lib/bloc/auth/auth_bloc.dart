// bloc/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<InitializeAuth>(_onInitializeAuth);
    on<SignInUser>(_onSignInUser);
    on<SignUpUser>(_onSignUpUser);
    on<LogoutUser>(_onLogoutUser);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<ForgotPassword>(_onForgotPassword);
    on<ResetPassword>(_onResetPassword);
  }

  Future<void> _onInitializeAuth(
      InitializeAuth event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthInitializing());

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Check if user is logged in
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final userName = prefs.getString('userName');
      final userEmail = prefs.getString('userEmail');
      final rememberMe = prefs.getBool('rememberMe') ?? false;

      if (userId != null && userName != null && userEmail != null && rememberMe) {
        emit(AuthAuthenticated(
          userId: userId,
          userName: userName,
          userEmail: userEmail,
          rememberMe: rememberMe,
        ));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInUser(
      SignInUser event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with real API call
      // Basic validation
      if (!event.email.contains('@')) {
        emit(AuthError('Invalid email address'));
        emit(AuthUnauthenticated());
        return;
      }

      if (event.password.length < 6) {
        emit(AuthError('Password must be at least 6 characters'));
        emit(AuthUnauthenticated());
        return;
      }

      // Mock successful login
      final userId = DateTime.now().millisecondsSinceEpoch.toString();
      final userName = event.email.split('@')[0]; // Use email prefix as name

      // Save user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
      await prefs.setString('userName', userName);
      await prefs.setString('userEmail', event.email);
      await prefs.setBool('rememberMe', event.rememberMe);

      emit(AuthAuthenticated(
        userId: userId,
        userName: userName,
        userEmail: event.email,
        rememberMe: event.rememberMe,
      ));
    } catch (e) {
      emit(AuthError('Login failed: ${e.toString()}'));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignUpUser(
      SignUpUser event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with real API call
      // Basic validation
      if (!event.email.contains('@')) {
        emit(AuthError('Invalid email address'));
        emit(AuthUnauthenticated());
        return;
      }

      if (event.password.length < 6) {
        emit(AuthError('Password must be at least 6 characters'));
        emit(AuthUnauthenticated());
        return;
      }

      if (event.name.isEmpty) {
        emit(AuthError('Name is required'));
        emit(AuthUnauthenticated());
        return;
      }

      // Mock successful sign up
      final userId = DateTime.now().millisecondsSinceEpoch.toString();

      // Save user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
      await prefs.setString('userName', event.name);
      await prefs.setString('userEmail', event.email);
      await prefs.setBool('rememberMe', true); // Auto remember on sign up

      emit(AuthAuthenticated(
        userId: userId,
        userName: event.name,
        userEmail: event.email,
        rememberMe: true,
      ));
    } catch (e) {
      emit(AuthError('Sign up failed: ${e.toString()}'));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogoutUser(
      LogoutUser event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      // Clear user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
      await prefs.remove('userName');
      await prefs.remove('userEmail');
      await prefs.remove('rememberMe');

      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Logout failed: ${e.toString()}'));
    }
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event,
      Emitter<AuthState> emit,
      ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final rememberMe = prefs.getBool('rememberMe') ?? false;

      if (userId != null && rememberMe) {
        final userName = prefs.getString('userName') ?? '';
        final userEmail = prefs.getString('userEmail') ?? '';

        emit(AuthAuthenticated(
          userId: userId,
          userName: userName,
          userEmail: userEmail,
          rememberMe: rememberMe,
        ));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onForgotPassword(
      ForgotPassword event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with real API call
      if (!event.email.contains('@')) {
        emit(AuthError('Invalid email address'));
        emit(AuthUnauthenticated());
        return;
      }

      emit(ForgotPasswordSent(
        'Password reset link sent to ${event.email}',
      ));

      // Return to unauthenticated after showing message
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Failed to send reset link: ${e.toString()}'));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onResetPassword(
      ResetPassword event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with real API call
      if (event.newPassword.length < 6) {
        emit(AuthError('Password must be at least 6 characters'));
        emit(AuthUnauthenticated());
        return;
      }

      emit(PasswordResetSuccess('Password reset successfully!'));

      // Return to unauthenticated after showing message
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Failed to reset password: ${e.toString()}'));
      emit(AuthUnauthenticated());
    }
  }
}