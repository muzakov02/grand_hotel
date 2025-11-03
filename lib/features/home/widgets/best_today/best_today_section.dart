import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/bloc/best_today/best_today_bloc.dart';
import 'package:grand_hotel/bloc/best_today/best_today_state.dart';

import 'best_today_card.dart';

class BestTodaySection extends StatelessWidget {
  const BestTodaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestTodayBloc, BestTodayState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Best Today',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text('🔥', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // See All page
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            if (state is BestTodayLoading)
              _buildLoadingList()
            else if (state is BestTodayLoaded)
              _buildHotelsList(context, state)
            else if (state is BestTodayError)
                _buildError(state.message)
              else
                _buildLoadingList(),
          ],
        );
      },
    );
  }

  Widget _buildLoadingList() {
    return SizedBox(
      height: 245,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHotelsList(BuildContext context, BestTodayLoaded state) {
    return SizedBox(
      height: 101,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: state.hotels.length,
        itemBuilder: (context, index) {
          final hotel = state.hotels[index];
          final isFavorite = state.favoriteIds.contains(hotel.id);
          return BestTodayCard(hotel: hotel, isFavorite: isFavorite);
        },
      ),
    );
  }

  Widget _buildError(String message) {
    return Container(
      height: 101,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(message, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}

// Best Today Card
