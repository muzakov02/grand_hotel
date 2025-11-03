// bloc/search_hotel/search_hotels_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/bloc/search_hotel/search_hotels_event.dart';
import 'package:grand_hotel/bloc/search_hotel/search_hotels_state.dart';
import 'package:grand_hotel/models/full_hotel.dart';

class SearchHotelsBloc extends Bloc<SearchHotelsEvent, SearchHotelsState> {
  SearchHotelsBloc() : super(SearchHotelsInitial()) {
    on<LoadSearchHotels>(_onLoadSearchHotels);
    on<ToggleHotelFavorite>(_onToggleHotelFavorite);
    on<FilterSearchHotels>(_onFilterSearchHotels);
    on<ResetSearchFilters>(_onResetSearchFilters); // 👈 YANGI HANDLER
  }

  Future<void> _onLoadSearchHotels(
      LoadSearchHotels event,
      Emitter<SearchHotelsState> emit,
      ) async {
    emit(SearchHotelsLoading());
    try {
      await Future.delayed(Duration(milliseconds: 500));
      final hotels = _getSampleHotels();
      emit(SearchHotelsLoaded(allHotels: hotels));
    } catch (e) {
      emit(SearchHotelsError('Mehmonxonalarni yuklashda xatolik'));
    }
  }

  void _onToggleHotelFavorite(
      ToggleHotelFavorite event,
      Emitter<SearchHotelsState> emit,
      ) {
    if (state is SearchHotelsLoaded) {
      final currentState = state as SearchHotelsLoaded;
      final updatedHotels = currentState.allHotels.map((hotel) {
        if (hotel.id == event.hotelId) {
          return hotel.copyWith(isFavorite: !hotel.isFavorite);
        }
        return hotel;
      }).toList();

      emit(SearchHotelsLoaded(
        allHotels: updatedHotels,
        selectedCategory: currentState.selectedCategory,
      ));
    }
  }

  void _onFilterSearchHotels(
      FilterSearchHotels event,
      Emitter<SearchHotelsState> emit,
      ) {
    if (state is SearchHotelsLoaded) {
      final currentState = state as SearchHotelsLoaded;
      var filtered = currentState.allHotels;

      // Category filter
      if (event.category != null && event.category != 'All') {
        filtered = filtered.where((h) =>
            h.amenities.contains(event.category)
        ).toList();
      }

      // Search query filter
      if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
        filtered = filtered.where((h) =>
        h.name.toLowerCase().contains(event.searchQuery!.toLowerCase()) ||
            h.location.toLowerCase().contains(event.searchQuery!.toLowerCase())
        ).toList();
      }

      // Price range filter
      if (event.minPrice != null) {
        filtered = filtered.where((h) =>
        h.pricePerNight >= event.minPrice!
        ).toList();
      }

      if (event.maxPrice != null) {
        filtered = filtered.where((h) =>
        h.pricePerNight <= event.maxPrice!
        ).toList();
      }

      // Rating filter
      if (event.minRating != null) {
        filtered = filtered.where((h) =>
        h.rating >= event.minRating!
        ).toList();
      }

      // Location filter
      if (event.location != null && event.location!.isNotEmpty) {
        filtered = filtered.where((h) =>
            h.location.toLowerCase().contains(event.location!.toLowerCase())
        ).toList();
      }

      // Facilities filter
      if (event.facilities != null && event.facilities!.isNotEmpty) {
        filtered = filtered.where((h) {
          return event.facilities!.any((facility) =>
              h.amenities.contains(facility)
          );
        }).toList();
      }

      emit(SearchHotelsLoaded(
        allHotels: currentState.allHotels,
        filteredHotels: filtered,
        selectedCategory: event.category ?? currentState.selectedCategory,
      ));
    }
  }

  // 👇 YANGI METOD - RESET HANDLER
  void _onResetSearchFilters(
      ResetSearchFilters event,
      Emitter<SearchHotelsState> emit,
      ) {
    if (state is SearchHotelsLoaded) {
      final currentState = state as SearchHotelsLoaded;
      emit(SearchHotelsLoaded(
        allHotels: currentState.allHotels,
        filteredHotels: currentState.allHotels, // Barchani qaytarish
        selectedCategory: 'All',
      ));
    }
  }

  List<FullHotel> _getSampleHotels() {
    return [
      FullHotel(
        id: '1',
        name: 'Sapphire Cove Hotel',
        location: 'Key West, FL',
        pricePerNight: 290,
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
        bed: '3 bed',
        bath: '3 bathroom',
        isPopular: true,
        amenities: ['Hotels', 'Pool', 'WiFi', 'Parking', 'Free Wifi'],
        description: 'Chiroyli ko\'rinishli mehmonxona',
      ),
      FullHotel(
        id: '2',
        name: 'Breeze Hill Hotel',
        location: 'Palm Springs, CA',
        pricePerNight: 180,
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800',
        bed: '2 bed',
        bath: '3 bathroom',
        isPopular: true,
        amenities: ['Hotels', 'Pool', 'WiFi', 'Spa', 'Swimming Pool'],
        description: 'Tog\'lar ko\'rinishli hashamatli mehmonxona',
      ),
      FullHotel(
        id: '3',
        name: 'Ocean View Resort',
        location: 'Miami, FL',
        pricePerNight: 350,
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
        bed: '4 bed',
        bath: '4 bathroom',
        isPopular: true,
        amenities: ['Hotels', 'Pool', 'Beach', 'Restaurant', 'Free Wifi', 'Laundry'],
        description: 'Okean yoqasidagi lux mehmonxona',
      ),
      FullHotel(
        id: '4',
        name: 'Mountain Paradise Villa',
        location: 'Aspen, CO',
        pricePerNight: 420,
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
        bed: '5 bed',
        bath: '5 bathroom',
        isPopular: false,
        amenities: ['Villas', 'Fireplace', 'Spa', 'Gym', 'Tv'],
        description: 'Tog\'lardagi go\'zal villa',
      ),
      FullHotel(
        id: '5',
        name: 'San Diego Beach House',
        location: 'San Diego, CA',
        pricePerNight: 250,
        rating: 4.7,
        imageUrl: 'https://images.unsplash.com/photo-1584132967334-10e028bd69f7?w=800',
        bed: '3 bed',
        bath: '2 bathroom',
        isPopular: true,
        amenities: ['Hotels', 'Beach', 'WiFi', 'Pool', 'Free Wifi'],
        description: 'Plyaj yaqinidagi qulay mehmonxona',
      ),
      FullHotel(
        id: '6',
        name: 'New York City Apartment',
        location: 'New York, NY',
        pricePerNight: 320,
        rating: 4.6,
        imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
        bed: '2 bed',
        bath: '2 bathroom',
        isPopular: true,
        amenities: ['Apartments', 'WiFi', 'Gym', 'Laundry', 'Free Wifi'],
        description: 'Shahar markazidagi zamonaviy apartment',
      ),
      FullHotel(
        id: '7',
        name: 'Amsterdam Canal House',
        location: 'Amsterdam, Netherlands',
        pricePerNight: 280,
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800',
        bed: '3 bed',
        bath: '2 bathroom',
        isPopular: true,
        amenities: ['Hotels', 'WiFi', 'Restaurant', 'Free Wifi', 'Tv'],
        description: 'Kanal bo\'yidagi tarixiy mehmonxona',
      ),
    ];
  }
}