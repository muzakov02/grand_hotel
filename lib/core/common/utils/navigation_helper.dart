// core/common/utils/navigation_helper.dart
import 'package:flutter/material.dart';
import 'package:grand_hotel/features/detail/hotel_detail_screen.dart';
import 'package:grand_hotel/models/full_hotel.dart';
import 'package:grand_hotel/models/property.dart';

import '../../../models/best_today_hotel.dart';

class NavigationHelper {
  static void navigateToHotelDetail({
    required BuildContext context,
    required Property property,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelDetailScreen(
          property: property,
        ),
      ),
    );
  }

  static void navigateFromFullHotel({
    required BuildContext context,
    required FullHotel hotel,
  }) {
    final property = Property(
      id: hotel.id,
      name: hotel.name,
      imageUrl: hotel.imageUrl,
      location: hotel.location,
      rating: hotel.rating,
      pricePerNight: hotel.pricePerNight,
      type: PropertyType.hotel,
      latitude: hotel.latitude ?? 41.2995,
      longitude: hotel.longitude ?? 69.2401,
      description: hotel.description ?? '',
    );

    navigateToHotelDetail(context: context, property: property);
  }

  static void navigateFromBestToday({
    required BuildContext context,
    required BestTodayHotel hotel,
  }) {
    final property = Property(
      id: hotel.id,
      name: hotel.name,
      imageUrl: hotel.imageUrl,
      location: hotel.location,
      rating: hotel.rating,
      pricePerNight: hotel.price,
      type: PropertyType.bestToday,
      latitude: hotel.latitude ?? 41.2995,
      longitude: hotel.longitude ?? 69.2401,
      description: hotel.description ?? '',
    );

    navigateToHotelDetail(context: context, property: property);
  }
}