class Property {
  final String id;
  final String name;
  final String location;
  final double pricePerNight;
  final double rating;
  final String imageUrl;
  final PropertyType type;
  final bool isRecommended;
  final String description;
  final double latitude;
  final double longitude;

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.pricePerNight,
    required this.rating,
    required this.imageUrl,
    required this.type,
    required this.latitude,
    required this.longitude,
    this.isRecommended = false,
    this.description = '',
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      pricePerNight: (json['pricePerNight'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      type: _parsePropertyType(json['type']),
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      isRecommended: json['isRecommended'] ?? false,
      description: json['description'] ?? '',
    );
  }

  static PropertyType _parsePropertyType(String? type) {
    switch (type?.toLowerCase()) {
      case 'villa':
      case 'villas':
        return PropertyType.villas;
      case 'hotel':
      case 'hotels':
        return PropertyType.hotels;
      case 'apartment':
      case 'apartments':
        return PropertyType.apartments;
      case 'besttoday':
        return PropertyType.bestToday;
      default:
        return PropertyType.all;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'pricePerNight': pricePerNight,
      'rating': rating,
      'imageUrl': imageUrl,
      'type': type.toString().split('.').last,
      'latitude': latitude,
      'longitude': longitude,
      'isRecommended': isRecommended,
      'description': description,
    };
  }
}

enum PropertyType {
  all,
  villas,
  hotels,
  apartments,
  bestToday,
  hotel,
}
