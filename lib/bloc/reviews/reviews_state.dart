import '../../models/review.dart';

abstract class ReviewsState {}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<Review> reviews;
  ReviewsLoaded(this.reviews);
}

class ReviewsError extends ReviewsState {
  final String message;
  ReviewsError(this.message);
}