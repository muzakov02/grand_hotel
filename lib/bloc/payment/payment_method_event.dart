part of 'payment_method_bloc.dart';

abstract class PaymentMethodEvent extends Equatable {
  const PaymentMethodEvent();

  @override
  List<Object?> get props => [];
}

class LoadPaymentMethods extends PaymentMethodEvent {}

class AddPaymentMethod extends PaymentMethodEvent {
  final PaymentMethod paymentMethod;

  const AddPaymentMethod(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod];
}

class SelectPaymentMethod extends PaymentMethodEvent {
  final PaymentMethod paymentMethod;

  const SelectPaymentMethod(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod];
}

class RemovePaymentMethod extends PaymentMethodEvent {
  final String id;

  const RemovePaymentMethod(this.id);

  @override
  List<Object?> get props => [id];
}