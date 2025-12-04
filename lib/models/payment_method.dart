class PaymentMethod {
  final String id;
  final String name;
  final String type;
  final String? cardNumber;
  final String? iconPath;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    this.cardNumber,
    this.iconPath,
  });
}
