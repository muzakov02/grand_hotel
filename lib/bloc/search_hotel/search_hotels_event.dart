// bloc/search_hotel/search_hotels_event.dart
abstract class SearchHotelsEvent {}

class LoadSearchHotels extends SearchHotelsEvent {}

class ToggleHotelFavorite extends SearchHotelsEvent {
  final String hotelId;
  ToggleHotelFavorite(this.hotelId);
}

class FilterSearchHotels extends SearchHotelsEvent {
  final String? category;
  final String? searchQuery;
  final double? maxPrice;
  final double? minPrice;
  final double? minRating;
  final String? location;
  final List<String>? facilities;
  final bool? instantBook;
  final int? adults;
  final int? children;

  FilterSearchHotels({
    this.category,
    this.searchQuery,
    this.maxPrice,
    this.minPrice,
    this.minRating,
    this.location,
    this.facilities,
    this.instantBook,
    this.adults,
    this.children,
  });
}


class ResetSearchFilters extends SearchHotelsEvent {}