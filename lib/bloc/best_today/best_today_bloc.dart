import 'package:flutter_bloc/flutter_bloc.dart';
import 'best_today_event.dart';
import 'best_today_state.dart';
import 'package:grand_hotel/models/nearby_hotel.dart';

class BestTodayBloc extends Bloc<BestTodayEvent, BestTodayState> {
  BestTodayBloc() : super(BestTodayInitial()) {
    on<LoadBestTodayHotels>(_onLoadBestTodayHotels);
    on<RefreshBestTodayHotels>(_onRefreshBestTodayHotels);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadBestTodayHotels(
      LoadBestTodayHotels event,
      Emitter<BestTodayState> emit,
      ) async {
    emit(BestTodayLoading());

    try {
      // API dan ma'lumot olish (hozircha demo data)
      await Future.delayed(const Duration(seconds: 1));

      final hotels = _getDemoBestTodayHotels();

      emit(BestTodayLoaded(hotels: hotels));
    } catch (e) {
      emit(BestTodayError('Failed to load best today hotels: $e'));
    }
  }

  Future<void> _onRefreshBestTodayHotels(
      RefreshBestTodayHotels event,
      Emitter<BestTodayState> emit,
      ) async {
    add(LoadBestTodayHotels());
  }

  void _onToggleFavorite(
      ToggleFavorite event,
      Emitter<BestTodayState> emit,
      ) {
    if (state is BestTodayLoaded) {
      final currentState = state as BestTodayLoaded;
      final newFavorites = Set<String>.from(currentState.favoriteIds);

      if (newFavorites.contains(event.hotelId)) {
        newFavorites.remove(event.hotelId);
      } else {
        newFavorites.add(event.hotelId);
      }

      emit(currentState.copyWith(favoriteIds: newFavorites));
    }
  }

  List<BestTodayHotel> _getDemoBestTodayHotels() {
    return [
      BestTodayHotel(
        id: 'best_1',
        name: 'Tranquil Shores',
        location: 'Santa Monica, CA',
        imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
        rating: 4.4,
        reviewCount: 532,
        price: 120,
        originalPrice: 199,
        discountPercent: 40,
        isFeatured: true,
      ),
      BestTodayHotel(
        id: 'best_2',
        name: 'Ocean View Resort',
        location: 'Miami Beach, FL',
        imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
        rating: 4.7,
        reviewCount: 723,
        price: 180,
        originalPrice: 280,
        discountPercent: 36,
        isFeatured: true,
      ),
      BestTodayHotel(
        id: 'best_3',
        name: 'Mountain Retreat',
        location: 'Aspen, CO',
        imageUrl: 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa',
        rating: 4.9,
        reviewCount: 891,
        price: 250,
        originalPrice: 380,
        discountPercent: 34,
        isFeatured: false,
      ),
      BestTodayHotel(
        id: 'best_4',
        name: 'Urban Elegance',
        location: 'New York, NY',
        imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945',
        rating: 4.6,
        reviewCount: 645,
        price: 200,
        originalPrice: 320,
        discountPercent: 38,
        isFeatured: false,
      ),
      BestTodayHotel(
        id: 'best_5',
        name: 'Desert Oasis',
        location: 'Scottsdale, AZ',
        imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4',
        rating: 4.5,
        reviewCount: 456,
        price: 140,
        originalPrice: 220,
        discountPercent: 36,
        isFeatured: false,
      ),
    ];
  }
}