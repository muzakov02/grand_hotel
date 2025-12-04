class BestTodayHotel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double price;
  final double originalPrice;
  final int discountPercent;
  final bool isFeatured;
  final String description;
  final double? latitude;
  final double? longitude;

  BestTodayHotel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.originalPrice,
    required this.discountPercent,
    this.isFeatured = false,
    this.description = '',
    this.latitude,
    this.longitude,
  });

  factory BestTodayHotel.fromJson(Map<String, dynamic> json) {
    return BestTodayHotel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0.0).toDouble(),
      discountPercent: json['discountPercent'] ?? 0,
      isFeatured: json['isFeatured'] ?? false,
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'price': price,
      'originalPrice': originalPrice,
      'discountPercent': discountPercent,
      'isFeatured': isFeatured,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
