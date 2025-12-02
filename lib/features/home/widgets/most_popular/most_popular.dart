// widgets/most_popular/most_popular.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/widgets/animated_list_item.dart';
import '../../../../bloc/most_popular/most_popular_bloc.dart';
import '../../../../bloc/most_popular/most_popular_event.dart';
import '../../../../bloc/most_popular/most_popular_state.dart';
import '../../../../core/common/utils/navigation_helper.dart';
import 'hotel_card.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({super.key}); // ✅ property parametrini olib tashladik

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
              'Most Popular',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                // See All page
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
        const SizedBox(height: 12),

        // Hotels List
        SizedBox(
          height: 240,
          child: BlocBuilder<MostPopularBloc, MostPopularState>(
            builder: (context, state) {
              if (state is MostPopularLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is MostPopularError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: ${state.message}'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<MostPopularBloc>().add(
                            RefreshMostPopularHotels(),
                          );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is MostPopularLoaded) {
                final hotels = state.hotels;

                if (hotels.isEmpty) {
                  return const Center(
                    child: Text('No popular hotels available'),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: hotels.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index != hotels.length - 1 ? 16.0 : 0,
                      ),
                      child: AnimatedListItem(
                        index: index,
                        isVertical: false,
                        child: HotelCard(
                          hotel: hotels[index],
                          onTap: () {
                            // ✅ NavigationHelper ishlatish
                            NavigationHelper.navigateFromFullHotel(
                              context: context,
                              hotel: hotels[index],
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}