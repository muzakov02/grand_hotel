import '../../models/full_hotel.dart';

abstract class SearchHotelsState {}

class SearchHotelsInitial extends SearchHotelsState {}

class SearchHotelsLoading extends SearchHotelsState {}

class SearchHotelsLoaded extends SearchHotelsState {
  final List<FullHotel> allHotels;
  final List<FullHotel> filteredHotels;
  final String selectedCategory;

  SearchHotelsLoaded({
    required this.allHotels,
    List<FullHotel>? filteredHotels,
    this.selectedCategory = 'All',
  }) : filteredHotels = filteredHotels ?? allHotels;
}

class SearchHotelsError extends SearchHotelsState {
  final String message;
  SearchHotelsError(this.message);
}