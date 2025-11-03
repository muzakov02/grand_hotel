class Review {
  final String id;
  final String name;
  final double rating;
  final String imageUrl;
  final String description;


  Review({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
    this.description = '',

  });

  Review copyWith({
    String? id,
    String? name,
    double? rating,
    String? imageUrl,
    String? description,

  }) {
    return Review(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,

    );
  }
}