import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/nearby_hotel.dart';
import 'nearby_hotels_event.dart';
import 'nearby_hotels_state.dart';

class NearbyHotelsBloc extends Bloc<NearbyHotelsEvent, NearbyHotelsState> {
  NearbyHotelsBloc() : super(NearbyHotelsInitial()) {
    on<LoadNearbyHotels>(_onLoadNearbyHotels);
    on<RefreshNearbyHotels>(_onRefreshNearbyHotels);
  }

  Future<void> _onLoadNearbyHotels(
      LoadNearbyHotels event,
      Emitter<NearbyHotelsState> emit,
      ) async {
    emit(NearbyHotelsLoading());

    try {
      // Default location (Tashkent)
      final lat = event.latitude ?? 41.2995;
      final lng = event.longitude ?? 69.2401;


      await Future.delayed(const Duration(seconds: 1));

      final hotels = _getDemoNearbyHotels();

      emit(NearbyHotelsLoaded(
        hotels: hotels,
        userLatitude: lat,
        userLongitude: lng,
      ));
    } catch (e) {
      emit(NearbyHotelsError('Failed to load nearby hotels: $e'));
    }
  }

  Future<void> _onRefreshNearbyHotels(
      RefreshNearbyHotels event,
      Emitter<NearbyHotelsState> emit,
      ) async {
    if (state is NearbyHotelsLoaded) {
      final currentState = state as NearbyHotelsLoaded;
      add(LoadNearbyHotels(
        latitude: currentState.userLatitude,
        longitude: currentState.userLongitude,
      ));
    } else {
      add(LoadNearbyHotels());
    }
  }

  List<NearbyHotel> _getDemoNearbyHotels() {
    return [
      NearbyHotel.fromLatLng(
        id: 'nearby_1',
        name: 'Grand Meridian Hotel',
        location: 'Tashkent, Uzbekistan',
        latitude: 41.3111,
        longitude: 69.2797,
        imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945',
        rating: 4.5,
        reviewCount: 342,
        price: 150,
        distance: 2.3,
      ),
      NearbyHotel.fromLatLng(
        id: 'nearby_2',
        name: 'City Palace Hotel',
        location: 'Downtown Tashkent',
        latitude: 41.2995,
        longitude: 69.2401,
        imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
        rating: 4.2,
        reviewCount: 256,
        price: 120,
        distance: 0.8,
      ),
      NearbyHotel.fromLatLng(
        id: 'nearby_3',
        name: 'Luxury Suites Tashkent',
        location: 'Yunusabad District',
        latitude: 41.3258,
        longitude: 69.2888,
        imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4',
        rating: 4.8,
        reviewCount: 489,
        price: 200,
        distance: 3.5,
      ),
      NearbyHotel.fromLatLng(
        id: 'nearby_4',
        name: 'Business Inn',
        location: 'Mirzo Ulugbek District',
        latitude: 41.3395,
        longitude: 69.3342,
        imageUrl: 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa',
        rating: 4.0,
        reviewCount: 178,
        price: 95,
        distance: 5.2,
      ),
    ];
  }
}