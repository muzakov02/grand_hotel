import '../models/payment_card.dart';

abstract class CardRepository {
  Future<List<PaymentCard>> getCards();

  Future<void> addCard(PaymentCard card);

  Future<void> deleteCard(String cardId);

  Future<void> setDefaultCard(String cardId);
}

class CardRepositoryImpl implements CardRepository {
  @override
  Future<List<PaymentCard>> getCards() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      PaymentCard(
        id: '1',
        cardType: 'VISA',
        balance: '\$3,242.23',
        cardNumber: '9865 3567 4563 4235',
        expiryDate: '12/24',
        startColor: '0xFF5B57D4',
        endColor: '0xFF7B78E8',
        logoAsset: 'VISA',
        isDefault: true,
      ),
      PaymentCard(
        id: '2',
        cardType: 'Mastercard',
        balance: '\$4,570.80',
        cardNumber: '5294 2436 4780 9568',
        expiryDate: '12/24',
        startColor: '0xFF1E1E1E',
        endColor: '0xFF2D2D2D',
        logoAsset: 'Mastercard',
        isDefault: false,
      ),
    ];
  }

  @override
  Future<void> addCard(PaymentCard card) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> deleteCard(String cardId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> setDefaultCard(String cardId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
