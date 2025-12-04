// widgets/best_today/best_today_card.dart
import 'package:flutter/material.dart';
import 'package:grand_hotel/models/best_today_hotel.dart';

import '../../../../core/common/utils/navigation_helper.dart'; // ✅ Import

class BestTodayCard extends StatelessWidget {
  final BestTodayHotel hotel;
  final bool isFavorite;

  const BestTodayCard({
    super.key,
    required this.hotel,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.navigateFromBestToday(
          context: context,
          hotel: hotel,
        );
      },
      child: Container(
        width: 296,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                hotel.imageUrl,
                width: 74,
                height: 75,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildErrorImage(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: _buildHotelDetails()),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorImage() {
    return Container(
      width: 74,
      height: 75,
      color: Colors.grey[300],
      child: const Icon(Icons.image, size: 40, color: Colors.grey),
    );
  }

  Widget _buildHotelDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          hotel.name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Icon(Icons.location_on, size: 13, color: Colors.grey[600]),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                hotel.location,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRating(),
            _buildPrice(),
          ],
        ),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(Icons.star, size: 15, color: Colors.amber),
        const SizedBox(width: 4),
        Text(
          '${hotel.rating}',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        Text(
          ' (${hotel.reviewCount})',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Row(
      children: [
        Text(
          '\$${hotel.price.toInt()}',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        Text(
          '\$${hotel.originalPrice.toInt()}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.red[400],
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }
}
