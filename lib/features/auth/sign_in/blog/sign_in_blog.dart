import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<SignInEvent>((event, emit) {
      event.map(
        submitted: (e) {
          // async ishni alohida chaqiramiz
          _handleSubmitted(e, emit);
        },
      );
    });
  }

  Future<void> _handleSubmitted(_Submitted e, Emitter<SignInState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    await Future.delayed(const Duration(seconds: 2)); // fake API

    if (e.email == "test@gmail.com" && e.password == "123456") {
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Invalid email or password",
      ));
    }
  }
}
