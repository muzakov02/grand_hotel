import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grand_hotel/bloc/reviews/reviews_bloc.dart';
import 'package:grand_hotel/bloc/reviews/reviews_event.dart';
import 'package:grand_hotel/features/detail/widgets/facilities/all_facilities.dart';
import 'package:grand_hotel/features/detail/widgets/recommendation/recommendation_section.dart';
import 'package:grand_hotel/features/detail/widgets/reviews/reviews_section.dart';
import 'package:grand_hotel/models/full_hotel.dart';

class HotelDetailScreen extends StatelessWidget {
  final FullHotel hotel;

  const HotelDetailScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewsBloc()..add(LoadReviews(hotel.id)),
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image (to'liq ekran)
            Positioned.fill(
              child: Image.network(
                hotel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            // AppBar (shaffof)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

                      // Title
                      const Text(
                        'Detail',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),

                      // Menu button
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // DraggableScrollableSheet (pastdan chiquvchi content)
            DraggableScrollableSheet(
              initialChildSize: 0.65, // 65% ekran balandligi
              minChildSize: 0.65, // Minimal 65%
              maxChildSize: 0.9, // Maksimal 90%
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Drag handle
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),

                          // Hotel name and rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hotel.name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          hotel.location,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Row(
                                          children: [
                                            const Icon(Icons.star,
                                                color: Colors.amber, size: 18),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${hotel.rating}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Favorite button
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/icons/changes.svg',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Common Facilities
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Common Facilities',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AllFacilitiesScreen(
                                            hotelId: hotel.id,
                                          ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'See All',
                                  style: TextStyle(color: Color(0xFF2853AF)),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Facilities icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildFacilityIcon('ice', 'Ac'),
                              _buildFacilityIcon('restaurant', 'Restaurant'),
                              _buildFacilityIcon(
                                  'swimming', 'Swimming\nPool'),
                              _buildFacilityIcon(
                                  '24', '24-Hours\nFront Desk'),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Description
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                  text: hotel.description.isNotEmpty
                                      ? '${hotel.description}.....'
                                      : 'The ideal place for those looking for a luxurious and tranquil holiday experience with stunning sea views.....',
                                ),
                                TextSpan(
                                  text: 'Read More',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Read More bosilganda
                                    },
                                ),
                              ],
                            ),
                            maxLines: 3,
                          ),

                          const SizedBox(height: 12),

                          // Location
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Open Map'),
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

                          const SizedBox(height: 12),

                          // ✅ REVIEWS SECTION (faqat 2 ta)
                          ReviewsSection(hotelId: hotel.id),

                          // Recommendation Section
                          const RecommendationSection(),

                          const SizedBox(height: 100), // Space for bottom button
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // Bottom Price and Booking button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      // Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            '\$${hotel.pricePerNight.toInt()}.00',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),

                      // Booking button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F5FD7),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Booking Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityIcon(String iconName, String label) {
    return SizedBox(
      width: 64,
      height: 94,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 56,
            width: 56,
            child: SvgPicture.asset(
              'assets/icons/$iconName.svg',
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
