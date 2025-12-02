// models/payment_method.dart
class PaymentMethod {
  final String id;
  final String name;
  final String type; // 'card', 'visa', 'paypal', etc.
  final String? cardNumber; // Last 4 digits yoki to'liq raqam
  final String? iconPath; // Asset path

  PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    this.cardNumber,
    this.iconPath,
  });
}