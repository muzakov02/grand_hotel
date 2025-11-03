// bloc/recommended/recommended_state.dart
import 'package:grand_hotel/models/property.dart';

abstract class RecommendedState {}

class RecommendedInitial extends RecommendedState {}

class RecommendedLoading extends RecommendedState {}

class RecommendedLoaded extends RecommendedState {
  final List<Property> properties;
  final PropertyType selectedType;

  RecommendedLoaded({
    required this.properties,
    this.selectedType = PropertyType.all,
  });

  RecommendedLoaded copyWith({
    List<Property>? properties,
    PropertyType? selectedType,
  }) {
    return RecommendedLoaded(
      properties: properties ?? this.properties,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}

class RecommendedError extends RecommendedState {
  final String message;

  RecommendedError(this.message);
}