part of 'payment_method_bloc.dart';

class PaymentMethodState extends Equatable {
  final List<PaymentMethod> paymentMethods;
  final PaymentMethod? selectedPaymentMethod;
  final bool isLoading;

  const PaymentMethodState({
    this.paymentMethods = const [],
    this.selectedPaymentMethod,
    this.isLoading = false,
  });

  PaymentMethodState copyWith({
    List<PaymentMethod>? paymentMethods,
    PaymentMethod? selectedPaymentMethod,
    bool? isLoading,
  }) {
    return PaymentMethodState(
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [paymentMethods, selectedPaymentMethod, isLoading];
}