// // dart format width=80
// // coverage:ignore-file
// // GENERATED CODE - DO NOT MODIFY BY HAND
// // ignore_for_file: type=lint
// // ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
//
// part of 'sign_up_state.dart';
//
// // **************************************************************************
// // FreezedGenerator
// // **************************************************************************
//
// // dart format off
// T _$identity<T>(T value) => value;
//
// /// @nodoc
// mixin _$SignUpState {
//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType && other is SignUpState);
//   }
//
//   @override
//   int get hashCode => runtimeType.hashCode;
//
//   @override
//   String toString() {
//     return 'SignUpState()';
//   }
// }
//
// /// @nodoc
// class $SignUpStateCopyWith<$Res> {
//   $SignUpStateCopyWith(SignUpState _, $Res Function(SignUpState) __);
// }
//
// /// @nodoc
//
// class _Initial implements SignUpState {
//   const _Initial();
//
//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType && other is _Initial);
//   }
//
//   @override
//   int get hashCode => runtimeType.hashCode;
//
//   @override
//   String toString() {
//     return 'SignUpState.initial()';
//   }
// }
//
// /// @nodoc
//
// class _Loading implements SignUpState {
//   const _Loading();
//
//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType && other is _Loading);
//   }
//
//   @override
//   int get hashCode => runtimeType.hashCode;
//
//   @override
//   String toString() {
//     return 'SignUpState.loading()';
//   }
// }
//
// /// @nodoc
//
// class _Success implements SignUpState {
//   const _Success();
//
//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType && other is _Success);
//   }
//
//   @override
//   int get hashCode => runtimeType.hashCode;
//
//   @override
//   String toString() {
//     return 'SignUpState.success()';
//   }
// }
//
// /// @nodoc
//
// class _Failure implements SignUpState {
//   const _Failure(this.message);
//
//   final String message;
//
//   /// Create a copy of SignUpState
//   /// with the given fields replaced by the non-null parameter values.
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   @pragma('vm:prefer-inline')
//   _$FailureCopyWith<_Failure> get copyWith =>
//       __$FailureCopyWithImpl<_Failure>(this, _$identity);
//
//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _Failure &&
//             (identical(other.message, message) || other.message == message));
//   }
//
//   @override
//   int get hashCode => Object.hash(runtimeType, message);
//
//   @override
//   String toString() {
//     return 'SignUpState.failure(message: $message)';
//   }
// }
//
// /// @nodoc
// abstract mixin class _$FailureCopyWith<$Res>
//     implements $SignUpStateCopyWith<$Res> {
//   factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) =
//       __$FailureCopyWithImpl;
//   @useResult
//   $Res call({String message});
// }
//
// /// @nodoc
// class __$FailureCopyWithImpl<$Res> implements _$FailureCopyWith<$Res> {
//   __$FailureCopyWithImpl(this._self, this._then);
//
//   final _Failure _self;
//   final $Res Function(_Failure) _then;
//
//   /// Create a copy of SignUpState
//   /// with the given fields replaced by the non-null parameter values.
//   @pragma('vm:prefer-inline')
//   $Res call({
//     Object? message = null,
//   }) {
//     return _then(_Failure(
//       null == message
//           ? _self.message
//           : message // ignore: cast_nullable_to_non_nullable
//               as String,
//     ));
//   }
// }
//
// // dart format on
