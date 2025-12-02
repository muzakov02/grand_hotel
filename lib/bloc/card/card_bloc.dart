import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/card_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({required this.cardRepository}) : super(CardInitial()) {
    on<LoadCards>(_onLoadCards);
    on<AddCard>(_onAddCard);
    on<DeleteCard>(_onDeleteCard);
    on<SelectDefaultCard>(_onSelectDefaultCard);
  }

  Future<void> _onLoadCards(
      LoadCards event,
      Emitter<CardState> emit,
      ) async {
    emit(CardLoading());
    try {
      final cards = await cardRepository.getCards();
      final defaultCard = cards.firstWhere(
            (card) => card.isDefault,
        orElse: () => cards.first,
      );
      emit(CardLoaded(cards: cards, selectedCardId: defaultCard.id));
    } catch (e) {
      emit(CardError('Failed to load cards: ${e.toString()}'));
    }
  }

  Future<void> _onAddCard(
      AddCard event,
      Emitter<CardState> emit,
      ) async {
    if (state is CardLoaded) {
      try {
        await cardRepository.addCard(event.card);
        final currentState = state as CardLoaded;
        final updatedCards = [...currentState.cards, event.card];
        emit(CardLoaded(
          cards: updatedCards,
          selectedCardId: currentState.selectedCardId,
        ));
        emit(const CardActionSuccess('Card added successfully'));
      } catch (e) {
        emit(CardError('Failed to add card: ${e.toString()}'));
      }
    }
  }

  Future<void> _onDeleteCard(
      DeleteCard event,
      Emitter<CardState> emit,
      ) async {
    if (state is CardLoaded) {
      try {
        await cardRepository.deleteCard(event.cardId);
        final currentState = state as CardLoaded;
        final updatedCards = currentState.cards
            .where((card) => card.id != event.cardId)
            .toList();

        String? newSelectedId = currentState.selectedCardId;
        if (currentState.selectedCardId == event.cardId && updatedCards.isNotEmpty) {
          newSelectedId = updatedCards.first.id;
        }

        emit(CardLoaded(
          cards: updatedCards,
          selectedCardId: newSelectedId,
        ));
        emit(const CardActionSuccess('Card deleted successfully'));
      } catch (e) {
        emit(CardError('Failed to delete card: ${e.toString()}'));
      }
    }
  }

  Future<void> _onSelectDefaultCard(
      SelectDefaultCard event,
      Emitter<CardState> emit,
      ) async {
    if (state is CardLoaded) {
      try {
        await cardRepository.setDefaultCard(event.cardId);
        final currentState = state as CardLoaded;
        final updatedCards = currentState.cards.map((card) {
          return card.copyWith(isDefault: card.id == event.cardId);
        }).toList();

        emit(CardLoaded(
          cards: updatedCards,
          selectedCardId: event.cardId,
        ));
      } catch (e) {
        emit(CardError('Failed to set default card: ${e.toString()}'));
      }
    }
  }
}
