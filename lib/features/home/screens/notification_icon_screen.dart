import 'package:flutter/material.dart';
import 'package:grand_hotel/features/home/widgets/notification/fitter_bottom_sheet.dart';
import 'package:grand_hotel/features/home/widgets/notification/notification_widget.dart';

import '../../../models/notification_model.dart';

class NotificationIconScreen extends StatefulWidget {
  const NotificationIconScreen({super.key});

  @override
  State<NotificationIconScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationIconScreen> {
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // MUHIM!
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const FilterBottomSheet();
      },
    );
  }

  final List<NotificationModel> notifications = [
    NotificationModel(
      id: '1',
      title: 'Hotel Eliminate Galian has added new accommodation rooms',
      imageUrl: 'assets/images/not1.png',
      time: '2 hours Ago',
    ),
    NotificationModel(
      id: '2',
      title:
          '20% discount if you stay on Saturday 27 November 2024 at Cerulean Hotel',
      imageUrl: 'assets/images/not2.png',
      time: '2 hours Ago',
    ),
    NotificationModel(
      id: '3',
      title:
          'Congratulations, you have successfully booked a room at Jade Gem Resort',
      imageUrl: 'assets/images/not3.png',
      time: '2 hours Ago',
    ),
    NotificationModel(
      id: '4',
      title: 'Payment has been successfully made, order is being processed',
      imageUrl: 'assets/images/not4.png',
      time: '2 hours Ago',
    ),
    NotificationModel(
      id: '5',
      title: 'Free breakfast at Double Oak Hotel for November 27, 2024',
      imageUrl: 'assets/images/not5.png',
      time: '2 hours Ago',
    ),
    NotificationModel(
      id: '6',
      title:
          'Congratulations, you have successfully booked a room at Double Oak Hotel',
      imageUrl: 'assets/images/not3.png',
      time: '2 hours Ago',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    // Today va Yesterday uchun ajratish
    final todayNotifications = notifications.sublist(0, 3); // 0, 1, 2
    final yesterdayNotifications = notifications.sublist(3); // 3, 4, 5

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showFilterBottomSheet();
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODAY SECTION
              const Text(
                'Today',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todayNotifications.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: NotificationWidget(
                      notification: todayNotifications[index],
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // YESTERDAY SECTION
              const Text(
                'Yesterday',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: yesterdayNotifications.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: NotificationWidget(
                      notification: yesterdayNotifications[index],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
