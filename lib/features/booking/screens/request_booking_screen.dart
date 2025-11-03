import 'package:flutter/material.dart';

class RequestBookingScreen extends StatefulWidget {
  const RequestBookingScreen({super.key});

  @override
  State<RequestBookingScreen> createState() => _RequestBookingScreenState();
}

class _RequestBookingScreenState extends State<RequestBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request to book',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
          ),
        ),
        // leading: IconButton(onPressed: Navigator.pop, icon: Icons.arrow_back),
      ),
    );
  }
}
