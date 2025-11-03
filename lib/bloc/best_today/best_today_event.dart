abstract class BestTodayEvent {}

class LoadBestTodayHotels extends BestTodayEvent {}

class RefreshBestTodayHotels extends BestTodayEvent {}

class ToggleFavorite extends BestTodayEvent {
  final String hotelId;

  ToggleFavorite(this.hotelId);
}