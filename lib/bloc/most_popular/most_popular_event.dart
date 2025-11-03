
abstract class MostPopularEvent {}

class LoadMostPopularHotels extends MostPopularEvent {}

class RefreshMostPopularHotels extends MostPopularEvent {}

class ToggleFavorite extends MostPopularEvent {
  final String hotelId;

  ToggleFavorite(this.hotelId);
}