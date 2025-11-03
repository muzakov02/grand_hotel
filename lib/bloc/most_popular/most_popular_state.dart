// bloc/most_popular/most_popular_state.dart
import 'package:grand_hotel/models/full_hotel.dart';

abstract class MostPopularState {}

class MostPopularInitial extends MostPopularState {}

class MostPopularLoading extends MostPopularState {}

class MostPopularLoaded extends MostPopularState {
  final List<FullHotel> hotels;

  MostPopularLoaded({required this.hotels});
}

class MostPopularError extends MostPopularState {
  final String message;

  MostPopularError(this.message);
}