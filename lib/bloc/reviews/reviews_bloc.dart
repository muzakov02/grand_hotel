import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/bloc/reviews/reviews_event.dart';
import 'package:grand_hotel/bloc/reviews/reviews_state.dart';

import '../../models/review.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  ReviewsBloc() : super(ReviewsInitial()) {
    on<LoadReviews>(_onLoadReviews);
    on<RefreshReviews>(_onRefreshReviews);
  }

  Future<void> _onLoadReviews(
      LoadReviews event,
      Emitter<ReviewsState> emit,
      ) async {
    emit(ReviewsLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      // ✅ Ko'proq mock data
      final reviews = [
        Review(
          id: '1',
          name: 'Kim Borrdy',
          imageUrl: 'assets/images/review1.png',
          rating: 4.5,
          description: 'Amazing! The room is good than the picture. Thanks for amazing experience!',
        ),
        Review(
          id: '2',
          name: 'Mirai Kamazuki',
          imageUrl: 'assets/images/review3.png',
          rating: 5.0,
          description: 'The service is on point, and I really like the facilities. Good job!',
        ),
        // ✅ Ko'proq reviewlar qo'shish
        Review(
          id: '3',
          name: 'Isenklen',
          imageUrl: 'assets/images/review2.png',
          rating: 5.0,
          description: 'The service is on point, and I really like the facilities. Good job!',
        ),
        Review(
          id: '4',
          name: 'Rezikan Akay',
          imageUrl: 'assets/images/review4.png',
          rating: 5.0,
          description: 'The service is on point, and I really like the facilities. Good job!',
        ),
        Review(
          id: '5',
          name: 'RezingKaly',
          imageUrl: 'assets/images/review5.png',
          rating: 5.0,
          description: 'The service is on point, and I really like the facilities. Good job!',
        ),
        Review(
          id: '6',
          name: 'Andziky',
          imageUrl: 'assets/images/review2.png',
          rating: 5.0,
          description: 'The service is on point, and I really like the facilities. Good job!',
        ),
      ];

      emit(ReviewsLoaded(reviews));
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }

  Future<void> _onRefreshReviews(
      RefreshReviews event,
      Emitter<ReviewsState> emit,
      ) async {
    add(LoadReviews(event.hotelId));
  }
}
