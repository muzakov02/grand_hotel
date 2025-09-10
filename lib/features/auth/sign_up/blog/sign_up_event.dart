import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_event.freezed.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.submitted({
    required String name,
    required String email,
    required String password,
  }) = _Submitted;
}
