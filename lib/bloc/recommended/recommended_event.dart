// bloc/recommended/recommended_event.dart
import '../../models/property.dart';

abstract class RecommendedEvent {}

class LoadRecommendedProperties extends RecommendedEvent {}

class FilterPropertiesByType extends RecommendedEvent {
  final PropertyType type;

  FilterPropertiesByType(this.type);
}

class RefreshRecommendedProperties extends RecommendedEvent {}