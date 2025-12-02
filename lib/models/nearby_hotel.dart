
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyHotel {
  final String id;
  final String name;
  final String location;
  final LatLng coordinates;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double price;
  final double distance; // km da

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
    return NearbyHotel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      coordinates: LatLng(
        json['latitude'] ?? 0.0,
        json['longitude'] ?? 0.0,
      ),
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
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
}