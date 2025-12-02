import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grand_hotel/features/home/screens/notification_icon_screen.dart';
import 'package:grand_hotel/features/profile/screens/help_support_screen.dart';
import 'package:grand_hotel/features/profile/screens/language_screen.dart';
import 'package:grand_hotel/features/profile/screens/security_screen.dart';
import 'package:grand_hotel/features/profile/screens/your_card_screen.dart';

import '../screens/notification_screen.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Setting',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        SettingCard(
          image: 'assets/icons/wallet.svg',
          title: 'Your Card',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const YourCardScreen()));
          },
        ),
        const SizedBox(height: 16),
        SettingCard(
          image: 'assets/icons/security.svg',
          title: 'Security',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SecurityScreen()));
          },
        ),
        const SizedBox(height: 16),
        SettingCard(
          image: 'assets/icons/notification.svg',
          title: 'Notification',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()));
          },
        ),
        const SizedBox(height: 16),
        SettingCard(
          image: 'assets/icons/internet.svg',
          title: 'Languages',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LanguageScreen()));
          },
        ),
        const SizedBox(height: 16),
        SettingCard(
          image: 'assets/icons/help.svg',
          title: 'Help and Support',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpSupportScreen()));
          },
        ),
      ],
    );
  }

  Widget SettingCard({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              children: [
                SvgPicture.asset(
                  image,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
