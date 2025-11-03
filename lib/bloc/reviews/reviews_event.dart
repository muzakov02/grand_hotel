abstract class ReviewsEvent {}

class LoadReviews extends ReviewsEvent {
  final String hotelId;
  LoadReviews(this.hotelId);
}

class RefreshReviews extends ReviewsEvent {
  final String hotelId;
  RefreshReviews(this.hotelId);
}