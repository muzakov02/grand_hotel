class FullHotel {
  final String id;
  final String name;
  final String location;
  final double pricePerNight;
  final double rating;
  final String imageUrl;
  final bool isFavorite;
  final bool isPopular;
  final List<String> amenities;
  final String description;
  final String bed;
  final String bath;
  final double? latitude;   // ✅ Qo'shildi
  final double? longitude;  // ✅ Qo'shildi

  FullHotel({
    required this.id,
    required this.name,
    required this.location,
    required this.pricePerNight,
    required this.rating,
    required this.imageUrl,
    this.isFavorite = false,
    this.isPopular = false,
    this.amenities = const [],
    this.description = '',
    required this.bed,
    required this.bath,
    this.latitude,
    this.longitude,
  });

  FullHotel copyWith({
    String? id,
    String? name,
    String? location,
    double? pricePerNight,
    double? rating,
    String? imageUrl,
    bool? isFavorite,
    bool? isPopular,
    List<String>? amenities,
    String? description,
    String? bed,
    String? bath,
    double? latitude,
    double? longitude,
  }) {
    return FullHotel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      isPopular: isPopular ?? this.isPopular,
      amenities: amenities ?? this.amenities,
      description: description ?? this.description,
      bed: bed ?? this.bed,
      bath: bath ?? this.bath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory FullHotel.fromJson(Map<String, dynamic> json) {
    return FullHotel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      pricePerNight: (json['pricePerNight'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      isPopular: json['isPopular'] ?? false,
      amenities: json['amenities'] != null
          ? List<String>.from(json['amenities'])
          : [],
      description: json['description'] ?? '',
      bed: json['bed'] ?? '',
      bath: json['bath'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'pricePerNight': pricePerNight,
      'rating': rating,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
      'isPopular': isPopular,
      'amenities': amenities,
      'description': description,
      'bed': bed,
      'bath': bath,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
