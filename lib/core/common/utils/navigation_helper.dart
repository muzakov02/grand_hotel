import 'package:flutter/material.dart';
import 'package:grand_hotel/features/detail/hotel_detail_screen.dart';
import 'package:grand_hotel/models/full_hotel.dart';
import 'package:grand_hotel/models/property.dart';

import '../../../models/best_today_hotel.dart';

class NavigationHelper {
  // Property'dan detail screenga o'tish
  static void navigateToHotelDetail({
    required BuildContext context,
    required Property property,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelDetailScreen(
          property: property,         ),
      ),
    );
  }

  // FullHotel'dan Property'ga konvert qilib o'tish
  static void navigateFromFullHotel({
    required BuildContext context,
    required FullHotel hotel,
  }) {
    final property = Property(
       hotel.id,
      name: hotel.name,
      imageUrl: hotel.imageUrl,
      location: hotel.location,
      rating: hotel.rating,
      pricePerNight: hotel.pricePerNight,
      type: PropertyType.hotel, id: '',
    );

    navigateToHotelDetail(context: context, property: property);
  }

  // BestTodayHotel'dan Property'ga konvert qilib o'tish
  static void navigateFromBestToday({
    required BuildContext context,
    required BestTodayHotel hotel,
  }) {
    final property = Property(
       hotel.id,
      name: hotel.name,
      imageUrl: hotel.imageUrl,
      location: hotel.location,
      rating: hotel.rating,
      pricePerNight: hotel.price,
      type: PropertyType.bestToday, id: '',
    );

    navigateToHotelDetail(context: context, property: property);
  }
}
