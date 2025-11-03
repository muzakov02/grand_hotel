abstract class NearbyHotelsEvent {}

class LoadNearbyHotels extends NearbyHotelsEvent {
  final double? latitude;
  final double? longitude;
  final double? radius; // km da

  LoadNearbyHotels({this.latitude, this.longitude, this.radius});
}

class RefreshNearbyHotels extends NearbyHotelsEvent {}