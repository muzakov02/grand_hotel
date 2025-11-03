// bloc/most_popular_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/data/hotel_data.dart';


import 'most_popular_event.dart';
import 'most_popular_state.dart';

class MostPopularBloc extends Bloc<MostPopularEvent, MostPopularState> {
  MostPopularBloc() : super(MostPopularInitial()) {
    on<LoadMostPopularHotels>(_onLoadMostPopularHotels);
    on<RefreshMostPopularHotels>(_onRefreshMostPopularHotels);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadMostPopularHotels(
      LoadMostPopularHotels event,
      Emitter<MostPopularState> emit,
      ) async {
    emit(MostPopularLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final hotels = HotelData.getMostPopularHotels();
      emit(MostPopularLoaded(hotels: hotels));
    } catch (e) {
      emit(MostPopularError(e.toString()));
    }
  }

  Future<void> _onRefreshMostPopularHotels(
      RefreshMostPopularHotels event,
      Emitter<MostPopularState> emit,
      ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final hotels = HotelData.getMostPopularHotels();
      emit(MostPopularLoaded(hotels: hotels));
    } catch (e) {
      emit(MostPopularError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event,
      Emitter<MostPopularState> emit,
      ) async {
    if (state is MostPopularLoaded) {
      final currentState = state as MostPopularLoaded;
      final updatedHotels = currentState.hotels.map((hotel) {
        if (hotel.id == event.hotelId) {
          return hotel.copyWith(isFavorite: !hotel.isFavorite);
        }
        return hotel;
      }).toList();

      emit(MostPopularLoaded(hotels: updatedHotels));
    }
  }
}