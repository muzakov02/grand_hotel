class PaymentCard {
  final String id;
  final String cardType;
  final String balance;
  final String cardNumber;
  final String expiryDate;
  final String startColor;
  final String endColor;
  final String logoAsset;
  final bool isDefault;

  PaymentCard({
    required this.id,
    required this.cardType,
    required this.balance,
    required this.cardNumber,
    required this.expiryDate,
    required this.startColor,
    required this.endColor,
    required this.logoAsset,
    this.isDefault = false,
  });

  PaymentCard copyWith({
    String? id,
    String? cardType,
    String? balance,
    String? cardNumber,
    String? expiryDate,
    String? startColor,
    String? endColor,
    String? logoAsset,
    bool? isDefault,
  }) {
    return PaymentCard(
      id: id ?? this.id,
      cardType: cardType ?? this.cardType,
      balance: balance ?? this.balance,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      startColor: startColor ?? this.startColor,
      endColor: endColor ?? this.endColor,
      logoAsset: logoAsset ?? this.logoAsset,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardType': cardType,
      'balance': balance,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'startColor': startColor,
      'endColor': endColor,
      'logoAsset': logoAsset,
      'isDefault': isDefault,
    };
  }

  factory PaymentCard.fromJson(Map<String, dynamic> json) {
    return PaymentCard(
      id: json['id'],
      cardType: json['cardType'],
      balance: json['balance'],
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      startColor: json['startColor'],
      endColor: json['endColor'],
      logoAsset: json['logoAsset'],
      isDefault: json['isDefault'] ?? false,
    );
  }
}
