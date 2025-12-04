import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  Future<void> _onSignInSubmitted(
      SignInSubmitted event, Emitter<SignInState> emit) async {
    emit(SignInLoading());


    await Future.delayed(const Duration(seconds: 1));


    if (event.email == "test@gmail.com" && event.password == "password123") {
      emit(SignInSuccess());
    } else {
      emit(SignInFailure("Email or password is incorrect"));
    }
  }
}