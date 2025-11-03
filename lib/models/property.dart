// models/property.dart
class Property {
  final String id;
  final String name;
  final String location;
  final double pricePerNight;
  final double rating;
  final String imageUrl;
  final PropertyType type;
  final bool isRecommended;

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.pricePerNight,
    required this.rating,
    required this.imageUrl,
    required this.type,
    this.isRecommended = false,
  });
}

enum PropertyType {
  all,
  villas,
  hotels,
  apartments,
}