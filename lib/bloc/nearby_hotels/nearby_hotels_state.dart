import 'package:grand_hotel/models/nearby_hotel.dart';

abstract class NearbyHotelsState {}

class NearbyHotelsInitial extends NearbyHotelsState {}

class NearbyHotelsLoading extends NearbyHotelsState {}

class NearbyHotelsLoaded extends NearbyHotelsState {
  final List<NearbyHotel> hotels;
  final double userLatitude;
  final double userLongitude;

  NearbyHotelsLoaded({
    required this.hotels,
    required this.userLatitude,
    required this.userLongitude,
  });
}

class NearbyHotelsError extends NearbyHotelsState {
  final String message;

  NearbyHotelsError(this.message);
}
