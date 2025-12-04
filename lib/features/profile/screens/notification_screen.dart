import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool newEventEnabled = true;
  bool deliveryEnabled = false;
  bool messageEnabled = true;
  bool paymentEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Messages Notifications',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                  _buildNotificationOption(
                    'New Event',
                    newEventEnabled,
                    (value) {
                      setState(() {
                        newEventEnabled = value;
                      });
                    },
                  ),
                  _buildNotificationOption(
                    'Delivery',
                    deliveryEnabled,
                    (value) {
                      setState(() {
                        deliveryEnabled = value;
                      });
                    },
                  ),
                  _buildNotificationOption(
                    'Message',
                    messageEnabled,
                    (value) {
                      setState(() {
                        messageEnabled = value;
                      });
                    },
                  ),
                  _buildNotificationOption(
                    'Payment',
                    paymentEnabled,
                    (value) {
                      setState(() {
                        paymentEnabled = value;
                      });
                    },
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOption(
    String title,
    bool value,
    Function(bool) onChanged, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        SwitchListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          value: value,
          onChanged: onChanged,
          activeThumbColor: const Color(0xFF2853AF),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        if (!isLast)
          Divider(
            color: Colors.grey.shade300,
            height: 1,
            thickness: 0.5,
          ),
      ],
    );
  }
}
