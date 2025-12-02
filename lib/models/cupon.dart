class Coupon {
  final String id;
  final String title;
  final String description;
  final String discount;
  final String validUntil;
  final bool isUsed;

  Coupon({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.validUntil,
    this.isUsed = false,
  });
}
