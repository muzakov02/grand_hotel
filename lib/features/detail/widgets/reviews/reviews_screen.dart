import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/features/detail/widgets/reviews/reviews_card.dart';

import '../../../../bloc/reviews/reviews_bloc.dart';
import '../../../../bloc/reviews/reviews_event.dart';
import '../../../../bloc/reviews/reviews_state.dart';
import '../../../../models/review.dart';

class ReviewsScreen extends StatelessWidget {
  final String hotelId;

  const ReviewsScreen({
    super.key,
    required this.hotelId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reviews',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Filter options
            },
          ),
        ],
      ),
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (context, state) {
          if (state is ReviewsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ReviewsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                  const SizedBox(height: 16),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.rate_review_outlined,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No reviews yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                _buildRatingSummary(reviews),

                const SizedBox(height: 16),

                // Reviews count
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Reviews (${reviews.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: reviews.length,  // Barcha reviewlar
                    itemBuilder: (context, index) {
                      return ReviewsCard(
                        review: reviews[index],
                        onTap: () {
                          // Review detail page (ixtiyoriy)
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // Rating Summary Widget (4.4 va rating bars)
  Widget _buildRatingSummary(List<Review> reviews) {
    final avgRating = reviews.isEmpty
        ? 0.0
        : reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

    final rating5 = reviews.where((r) => r.rating == 5.0).length;
    final rating4 = reviews.where((r) => r.rating >= 4.0 && r.rating < 5.0).length;
    final rating3 = reviews.where((r) => r.rating >= 3.0 && r.rating < 4.0).length;
    final rating2 = reviews.where((r) => r.rating >= 2.0 && r.rating < 3.0).length;
    final rating1 = reviews.where((r) => r.rating < 2.0).length;

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  avgRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < avgRating.floor()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  'Based on ${reviews.length} review',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Right side - Rating bars
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildRatingBar(5, rating5, reviews.length),
                _buildRatingBar(4, rating4, reviews.length),
                _buildRatingBar(3, rating3, reviews.length),
                _buildRatingBar(2, rating2, reviews.length),
                _buildRatingBar(1, rating1, reviews.length),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, int count, int total) {
    final percentage = total == 0 ? 0.0 : count / total;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$stars',
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
