import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState.initial()) {
    on<SignUpEvent>((event, emit) async {
      await event.map(
        submitted: (e) async {
          emit(const SignUpState.loading());

          await Future.delayed(const Duration(seconds: 2)); // fake API call

          if (e.password.length < 6) {
            emit(const SignUpState.failure('Password must be at least 6 characters'));
            return;
          }
          if (!e.email.contains('@')) {
            emit(const SignUpState.failure('Please enter a valid email'));
            return;
          }
          if (e.name.isEmpty) {
            emit(const SignUpState.failure('Name cannot be empty'));
            return;
          }

          emit(const SignUpState.success());
        },
      );
    });
  }
}
