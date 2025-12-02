// features/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/bloc/best_today/best_today_bloc.dart';
import 'package:grand_hotel/bloc/best_today/best_today_event.dart';
import 'package:grand_hotel/bloc/most_popular/most_popular_bloc.dart';
import 'package:grand_hotel/bloc/most_popular/most_popular_event.dart';
import 'package:grand_hotel/bloc/nearby_hotels/nearby_hotels_event.dart';
import 'package:grand_hotel/bloc/recommended/recommended_bloc.dart';
import 'package:grand_hotel/bloc/recommended/recommended_event.dart';
import 'package:grand_hotel/features/home/widgets/best_today/best_today_section.dart';
import 'package:grand_hotel/features/home/widgets/custom_location_bar.dart';
import 'package:grand_hotel/features/home/widgets/header.dart';
import 'package:grand_hotel/features/home/widgets/most_popular/most_popular.dart';

import '../../../bloc/nearby_hotels/nearby_hotels_bloc.dart' show NearbyHotelsBloc;
import '../widgets/recomended/recommended_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Barcha ma'lumotlarni refresh qilish
            context.read<MostPopularBloc>().add(LoadMostPopularHotels());
            context.read<RecommendedBloc>().add(LoadRecommendedProperties());
            context.read<NearbyHotelsBloc>().add(RefreshNearbyHotels());
            context.read<BestTodayBloc>().add(RefreshBestTodayHotels());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
                  const Header(name: 'Matr Kohler', location: 'Tashkent, UZ'),

                  const SizedBox(height: 20),

                  // Location Bar
                  const CustomLocationBar(),

                  const SizedBox(height: 24),

                  // Most Popular - ✅ property parametri olib tashlandi
                  const MostPopular(),

                  const SizedBox(height: 24),

                  // Recommended Section
                  const RecommendedSection(),

                  const SizedBox(height: 24),

                  // Map Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hotel Near You',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Open Map',
                          style: TextStyle(color: Color(0xFF2853AF),),),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Map placeholder
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.map,
                        size: 50,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Best Today Section
                  const BestTodaySection(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}