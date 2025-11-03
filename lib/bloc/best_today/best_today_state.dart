import 'package:grand_hotel/models/nearby_hotel.dart';

abstract class BestTodayState {}

class BestTodayInitial extends BestTodayState {}

class BestTodayLoading extends BestTodayState {}

class BestTodayLoaded extends BestTodayState {
  final List<BestTodayHotel> hotels;
  final Set<String> favoriteIds;

  BestTodayLoaded({
    required this.hotels,
    this.favoriteIds = const {},
  });

  BestTodayLoaded copyWith({
    List<BestTodayHotel>? hotels,
    Set<String>? favoriteIds,
  }) {
    return BestTodayLoaded(
      hotels: hotels ?? this.hotels,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}

class BestTodayError extends BestTodayState {
  final String message;

  BestTodayError(this.message);
}