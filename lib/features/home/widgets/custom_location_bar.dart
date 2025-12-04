import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../search/search_screen.dart';

class CustomLocationBar extends StatelessWidget {
  const CustomLocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE8F2FF),
          borderRadius: BorderRadius.circular(16),
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                'assets/icons/location2.svg',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You Can Change Your Location to show nearby villas ',
                    style: TextStyle(
                      color: Color(0xFF171725),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
