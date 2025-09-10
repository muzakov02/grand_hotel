import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.freezed.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.submitted({
    required String email,
    required String password,
  }) = _Submitted;

  const factory SignInEvent.emailChanged(String email) = _EmailChanged;
  const factory SignInEvent.passwordChanged(String password) = _PasswordChanged;
  const factory SignInEvent.rememberMeToggled(bool value) = _RememberMeToggled;
}
