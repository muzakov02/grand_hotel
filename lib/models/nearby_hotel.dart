import 'package:yandex_mapkit/yandex_mapkit.dart';

class NearbyHotel {
  final String id;
  final String name;
  final String location;
  final Point coordinates;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int price;
  final double distance;

  NearbyHotel({
    required this.id,
    required this.name,
    required this.location,
    required this.coordinates,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.distance,
  });

  factory NearbyHotel.fromJson(Map<String, dynamic> json) {
    final lat = (json['latitude'] ?? 0.0).toDouble();
    final lng = (json['longitude'] ?? 0.0).toDouble();

    return NearbyHotel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      coordinates: Point(latitude: lat, longitude: lng),
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      price: (json['price'] ?? 0).toInt(),
      distance: (json['distance'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'price': price,
      'distance': distance,
    };
  }

  factory NearbyHotel.fromLatLng({
    required String id,
    required String name,
    required String location,
    required double latitude,
    required double longitude,
    required String imageUrl,
    required double rating,
    required int reviewCount,
    required int price,
    required double distance,
  }) {
    return NearbyHotel(
      id: id,
      name: name,
      location: location,
      coordinates: Point(latitude: latitude, longitude: longitude),
      imageUrl: imageUrl,
      rating: rating,
      reviewCount: reviewCount,
      price: price,
      distance: distance,
    );
  }
}
