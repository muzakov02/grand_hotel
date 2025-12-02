import 'package:equatable/equatable.dart';

import '../../models/payment_card.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object?> get props => [];
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final List<PaymentCard> cards;
  final String? selectedCardId;

  const CardLoaded({
    required this.cards,
    this.selectedCardId,
  });

  @override
  List<Object?> get props => [cards, selectedCardId];

  CardLoaded copyWith({
    List<PaymentCard>? cards,
    String? selectedCardId,
  }) {
    return CardLoaded(
      cards: cards ?? this.cards,
      selectedCardId: selectedCardId ?? this.selectedCardId,
    );
  }
}

class CardError extends CardState {
  final String message;

  const CardError(this.message);

  @override
  List<Object?> get props => [message];
}

class CardActionSuccess extends CardState {
  final String message;

  const CardActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}