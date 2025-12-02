// widgets/recommended_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/bloc/recommended/recommended_bloc.dart';
import 'package:grand_hotel/bloc/recommended/recommended_event.dart';
import 'package:grand_hotel/bloc/recommended/recommended_state.dart';
import 'package:grand_hotel/features/home/widgets/recomended/property_card.dart';
import 'package:grand_hotel/features/home/widgets/recomended/property_type_filter.dart';

import '../../../../core/common/utils/navigation_helper.dart';



class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

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
              'Recomended for you',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigator.push(...)
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

        // Filter Chips
        const PropertyTypeFilter(),
        const SizedBox(height: 16),

        // Property List
        BlocBuilder<RecommendedBloc, RecommendedState>(
          builder: (context, state) {
            if (state is RecommendedLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is RecommendedError) {
              return Center(
                child: Column(
                  children: [
                    Text('Error: ${state.message}'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RecommendedBloc>().add(
                          RefreshRecommendedProperties(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is RecommendedLoaded) {
              final properties = state.properties;

              if (properties.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text('No properties available'),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  return PropertyCard(
                    property: properties[index],
                    onTap: () {
                      NavigationHelper.navigateToHotelDetail(
                        context: context,
                        property: properties[index],
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