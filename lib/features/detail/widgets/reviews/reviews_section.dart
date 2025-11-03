import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/features/detail/widgets/reviews/reviews_card.dart';
import 'package:grand_hotel/features/detail/widgets/reviews/reviews_screen.dart';

import '../../../../bloc/reviews/reviews_bloc.dart';
import '../../../../bloc/reviews/reviews_event.dart';
import '../../../../bloc/reviews/reviews_state.dart';

class ReviewsSection extends StatelessWidget {
  final String hotelId;

  const ReviewsSection({
    super.key,
    required this.hotelId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Reviews',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                final reviewsBloc = context.read<ReviewsBloc>();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: reviewsBloc,
                      child: ReviewsScreen(hotelId: hotelId),
                    ),
                  ),
                );
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // Reviews List - FAQAT 2 TA
        BlocBuilder<ReviewsBloc, ReviewsState>(
          builder: (context, state) {
            if (state is ReviewsLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is ReviewsError) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      'Error: ${state.message}',
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ReviewsBloc>().add(
                          RefreshReviews(hotelId),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is ReviewsLoaded) {
              final reviews = state.reviews;

              if (reviews.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'No reviews yet',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                );
              }

              // FAQAT 2 TA OLISH
              final limitedReviews = reviews.take(2).toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero, // ✅ Default padding ni olib tashlash
                itemCount: limitedReviews.length,
                itemBuilder: (context, index) {
                  return ReviewsCard(
                    review: limitedReviews[index],
                    onTap: () {
                      final reviewsBloc = context.read<ReviewsBloc>();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: reviewsBloc,
                            child: ReviewsScreen(hotelId: hotelId),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}