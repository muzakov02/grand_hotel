import 'package:equatable/equatable.dart';

import '../../models/payment_card.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object?> get props => [];
}

class LoadCards extends CardEvent {}

class AddCard extends CardEvent {
  final PaymentCard card;

  const AddCard(this.card);

  @override
  List<Object?> get props => [card];
}

class DeleteCard extends CardEvent {
  final String cardId;

  const DeleteCard(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

class SelectDefaultCard extends CardEvent {
  final String cardId;

  const SelectDefaultCard(this.cardId);

  @override
  List<Object?> get props => [cardId];
}