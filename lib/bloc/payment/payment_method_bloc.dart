import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/payment_method.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(const PaymentMethodState()) {
    on<LoadPaymentMethods>(_onLoadPaymentMethods);
    on<AddPaymentMethod>(_onAddPaymentMethod);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<RemovePaymentMethod>(_onRemovePaymentMethod);
  }

  void _onLoadPaymentMethods(
      LoadPaymentMethods event,
      Emitter<PaymentMethodState> emit,
      ) {
    // Default kartalar
    final defaultCards = [
      PaymentMethod(
        id: '1',
        name: 'Master Card',
        type: 'mastercard',
        cardNumber: '•••• 4587',
        iconPath: 'assets/icons/mastercard.svg',
      ),
      PaymentMethod(
        id: '2',
        name: 'Visa',
        type: 'visa',
        cardNumber: '•••• 1234',
        iconPath: 'assets/icons/visa.svg',
      ),
    ];

    emit(state.copyWith(paymentMethods: defaultCards));
  }

  void _onAddPaymentMethod(
      AddPaymentMethod event,
      Emitter<PaymentMethodState> emit,
      ) {
    final updatedMethods = List<PaymentMethod>.from(state.paymentMethods)
      ..add(event.paymentMethod);

    emit(state.copyWith(
      paymentMethods: updatedMethods,
      selectedPaymentMethod: event.paymentMethod, // Yangi kartani avtomatik tanlash
    ));
  }

  void _onSelectPaymentMethod(
      SelectPaymentMethod event,
      Emitter<PaymentMethodState> emit,
      ) {
    emit(state.copyWith(selectedPaymentMethod: event.paymentMethod));
  }

  void _onRemovePaymentMethod(
      RemovePaymentMethod event,
      Emitter<PaymentMethodState> emit,
      ) {
    final updatedMethods = state.paymentMethods
        .where((method) => method.id != event.id)
        .toList();

    emit(state.copyWith(paymentMethods: updatedMethods));
  }
}