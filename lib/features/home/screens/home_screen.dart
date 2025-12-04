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

import '../../../bloc/nearby_hotels/nearby_hotels_bloc.dart';
import '../widgets/nearby_hotels/nearby_hotels_section.dart';
import '../widgets/recomended/recommended_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NearbyHotelsBloc>().add(LoadNearbyHotels());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
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
                  const Header(name: 'Matr Kohler', location: 'Tashkent, UZ'),
                  const SizedBox(height: 20),
                  const CustomLocationBar(),
                  const SizedBox(height: 24),
                  const MostPopular(),
                  const SizedBox(height: 24),
                  const RecommendedSection(),
                  const SizedBox(height: 24),
                  const NearbyHotelsSection(),
                  const SizedBox(height: 24),
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

