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
    );
  }
}