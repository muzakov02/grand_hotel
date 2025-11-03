// bloc/recommended/recommended_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/data/property_data.dart';
import 'package:grand_hotel/bloc/recommended/recommended_event.dart';
import 'package:grand_hotel/bloc/recommended/recommended_state.dart';
import 'package:grand_hotel/models/property.dart';

class RecommendedBloc extends Bloc<RecommendedEvent, RecommendedState> {
  RecommendedBloc() : super(RecommendedInitial()) {
    on<LoadRecommendedProperties>(_onLoadRecommendedProperties);
    on<FilterPropertiesByType>(_onFilterPropertiesByType);
    on<RefreshRecommendedProperties>(_onRefreshRecommendedProperties);
  }

  Future<void> _onLoadRecommendedProperties(
      LoadRecommendedProperties event,
      Emitter<RecommendedState> emit,
      ) async {
    emit(RecommendedLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final properties = PropertyData.getRecommendedProperties();
      emit(RecommendedLoaded(
        properties: properties,
        selectedType: PropertyType.all,
      ));
    } catch (e) {
      emit(RecommendedError(e.toString()));
    }
  }

  Future<void> _onFilterPropertiesByType(
      FilterPropertiesByType event,
      Emitter<RecommendedState> emit,
      ) async {
    if (state is RecommendedLoaded) {
      try {
        final properties = PropertyData.getPropertiesByType(event.type);
        emit(RecommendedLoaded(
          properties: properties,
          selectedType: event.type,
        ));
      } catch (e) {
        emit(RecommendedError(e.toString()));
      }
    }
  }

  Future<void> _onRefreshRecommendedProperties(
      RefreshRecommendedProperties event,
      Emitter<RecommendedState> emit,
      ) async {
    if (state is RecommendedLoaded) {
      final currentState = state as RecommendedLoaded;
      try {
        final properties = PropertyData.getPropertiesByType(
          currentState.selectedType,
        );
        emit(RecommendedLoaded(
          properties: properties,
          selectedType: currentState.selectedType,
        ));
      } catch (e) {
        emit(RecommendedError(e.toString()));
      }
    }
  }
}