// // dart format width=80
// // coverage:ignore-file
// // GENERATED CODE - DO NOT MODIFY BY HAND
// // ignore_for_file: type=lint
// // ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
//
// part of 'sign_in_state.dart';
//
// // **************************************************************************
// // FreezedGenerator
// // **************************************************************************
//
// // dart format off
// T _$identity<T>(T value) => value;
//
// /// @nodoc
// mixin _$SignInState {
//   String get email;
//   String get password;
//   bool get rememberMe;
//   String? get emailError;
//   String? get passwordError;
//   bool get isLoading;
//   String? get errorMessage;
//   bool get isSuccess;
//
//   /// Create a copy of SignInState
//   /// with the given fields replaced by the non-null parameter values.
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   @pragma('vm:prefer-inline')
//   $SignInStateCopyWith<SignInState> get copyWith =>
//       _$SignInStateCopyWithImpl<SignInState>(this as SignInState, _$identity);
//
//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is SignInState &&
//             (identical(other.email, email) || other.email == email) &&
//             (identical(other.password, password) ||
//                 other.password == password) &&
//             (identical(other.rememberMe, rememberMe) ||
//                 other.rememberMe == rememberMe) &&
//             (identical(other.emailError, emailError) ||
//                 other.emailError == emailError) &&
//             (identical(other.passwordError, passwordError) ||
//                 other.passwordError == passwordError) &&
//             (identical(other.isLoading, isLoading) ||
//                 other.isLoading == isLoading) &&
//             (identical(other.errorMessage, errorMessage) ||
//                 other.errorMessage == errorMessage) &&
//             (identical(other.isSuccess, isSuccess) ||
//                 other.isSuccess == isSuccess));
//   }
//
//   @override
//   int get hashCode => Object.hash(runtimeType, email, password, rememberMe,
//       emailError, passwordError, isLoading, errorMessage, isSuccess);
//
//   @override
//   String toString() {
//     return 'SignInState(email: $email, password: $password, rememberMe: $rememberMe, emailError: $emailError, passwordError: $passwordError, isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess)';
//   }
// }
//
// /// @nodoc
// abstract mixin class $SignInStateCopyWith<$Res> {
//   factory $SignInStateCopyWith(
//           SignInState value, $Res Function(SignInState) _then) =
//       _$SignInStateCopyWithImpl;
//   @useResult
//   $Res call(
//       {String email,
//       String password,
//       bool rememberMe,
//       String? emailError,
//       String? passwordError,
//       bool isLoading,
//       String? errorMessage,
//       bool isSuccess});
// }
//
// /// @nodoc
// class _$SignInStateCopyWithImpl<$Res> implements $SignInStateCopyWith<$Res> {
//   _$SignInStateCopyWithImpl(this._self, this._then);
//
//   final SignInState _self;
//   final $Res Function(SignInState) _then;
//
//   /// Create a copy of SignInState
//   /// with the given fields replaced by the non-null parameter values.
//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? email = null,
//     Object? password = null,
//     Object? rememberMe = null,
//     Object? emailError = freezed,
//     Object? passwordError = freezed,
//     Object? isLoading = null,
//     Object? errorMessage = freezed,
//     Object? isSuccess = null,
//   }) {
//     return _then(_self.copyWith(
//       email: null == email
//           ? _self.email
//           : email // ignore: cast_nullable_to_non_nullable
//               as String,
//       password: null == password
//           ? _self.password
//           : password // ignore: cast_nullable_to_non_nullable
//               as String,
//       rememberMe: null == rememberMe
//           ? _self.rememberMe
//           : rememberMe // ignore: cast_nullable_to_non_nullable
//               as bool,
//       emailError: freezed == emailError
//           ? _self.emailError
//           : emailError // ignore: cast_nullable_to_non_nullable
//               as String?,
//       passwordError: freezed == passwordError
//           ? _self.passwordError
//           : passwordError // ignore: cast_nullable_to_non_nullable
//               as String?,
//       isLoading: null == isLoading
//           ? _self.isLoading
//           : isLoading // ignore: cast_nullable_to_non_nullable
//               as bool,
//       errorMessage: freezed == errorMessage
//           ? _self.errorMessage
//           : errorMessage // ignore: cast_nullable_to_non_nullable
//               as String?,
//       isSuccess: null == isSuccess
//           ? _self.isSuccess
//           : isSuccess // ignore: cast_nullable_to_non_nullable
//               as bool,
//     ));
//   }
// }
//
// /// @nodoc
//
// class _SignInState implements SignInState {
//   const _SignInState(
//       {this.email = '',
//       this.password = '',
//       this.rememberMe = false,
//       this.emailError,
//       this.passwordError,
//       this.isLoading = false,
//       this.errorMessage,
//       this.isSuccess = false});
//
//   @override
//   @JsonKey()
//   final String email;
//   @override
//   @JsonKey()
//   final String password;
//   @override
//   @JsonKey()
//   final bool rememberMe;
//   @override
//   final String? emailError;
//   @override
//   final String? passwordError;
//   @override
//   @JsonKey()
//   final bool isLoading;
//   @override
//   final String? errorMessage;
//   @override
//   @JsonKey()
//   final bool isSuccess;
//
//   /// Create a copy of SignInState
//   /// with the given fields replaced by the non-null parameter values.
//   @override
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   @pragma('vm:prefer-inline')
//   _$SignInStateCopyWith<_SignInState> get copyWith =>
//       __$SignInStateCopyWithImpl<_SignInState>(this, _$identity);
//
//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _SignInState &&
//             (identical(other.email, email) || other.email == email) &&
//             (identical(other.password, password) ||
//                 other.password == password) &&
//             (identical(other.rememberMe, rememberMe) ||
//                 other.rememberMe == rememberMe) &&
//             (identical(other.emailError, emailError) ||
//                 other.emailError == emailError) &&
//             (identical(other.passwordError, passwordError) ||
//                 other.passwordError == passwordError) &&
//             (identical(other.isLoading, isLoading) ||
//                 other.isLoading == isLoading) &&
//             (identical(other.errorMessage, errorMessage) ||
//                 other.errorMessage == errorMessage) &&
//             (identical(other.isSuccess, isSuccess) ||
//                 other.isSuccess == isSuccess));
//   }
//
//   @override
//   int get hashCode => Object.hash(runtimeType, email, password, rememberMe,
//       emailError, passwordError, isLoading, errorMessage, isSuccess);
//
//   @override
//   String toString() {
//     return 'SignInState(email: $email, password: $password, rememberMe: $rememberMe, emailError: $emailError, passwordError: $passwordError, isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess)';
//   }
// }
//
// /// @nodoc
// abstract mixin class _$SignInStateCopyWith<$Res>
//     implements $SignInStateCopyWith<$Res> {
//   factory _$SignInStateCopyWith(
//           _SignInState value, $Res Function(_SignInState) _then) =
//       __$SignInStateCopyWithImpl;
//   @override
//   @useResult
//   $Res call(
//       {String email,
//       String password,
//       bool rememberMe,
//       String? emailError,
//       String? passwordError,
//       bool isLoading,
//       String? errorMessage,
//       bool isSuccess});
// }
//
// /// @nodoc
// class __$SignInStateCopyWithImpl<$Res> implements _$SignInStateCopyWith<$Res> {
//   __$SignInStateCopyWithImpl(this._self, this._then);
//
//   final _SignInState _self;
//   final $Res Function(_SignInState) _then;
//
//   /// Create a copy of SignInState
//   /// with the given fields replaced by the non-null parameter values.
//   @override
//   @pragma('vm:prefer-inline')
//   $Res call({
//     Object? email = null,
//     Object? password = null,
//     Object? rememberMe = null,
//     Object? emailError = freezed,
//     Object? passwordError = freezed,
//     Object? isLoading = null,
//     Object? errorMessage = freezed,
//     Object? isSuccess = null,
//   }) {
//     return _then(_SignInState(
//       email: null == email
//           ? _self.email
//           : email // ignore: cast_nullable_to_non_nullable
//               as String,
//       password: null == password
//           ? _self.password
//           : password // ignore: cast_nullable_to_non_nullable
//               as String,
//       rememberMe: null == rememberMe
//           ? _self.rememberMe
//           : rememberMe // ignore: cast_nullable_to_non_nullable
//               as bool,
//       emailError: freezed == emailError
//           ? _self.emailError
//           : emailError // ignore: cast_nullable_to_non_nullable
//               as String?,
//       passwordError: freezed == passwordError
//           ? _self.passwordError
//           : passwordError // ignore: cast_nullable_to_non_nullable
//               as String?,
//       isLoading: null == isLoading
//           ? _self.isLoading
//           : isLoading // ignore: cast_nullable_to_non_nullable
//               as bool,
//       errorMessage: freezed == errorMessage
//           ? _self.errorMessage
//           : errorMessage // ignore: cast_nullable_to_non_nullable
//               as String?,
//       isSuccess: null == isSuccess
//           ? _self.isSuccess
//           : isSuccess // ignore: cast_nullable_to_non_nullable
//               as bool,
//     ));
//   }
// }
//
// // dart format on
