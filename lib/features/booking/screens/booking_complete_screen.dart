import 'package:flutter/material.dart';
import 'package:grand_hotel/features/booking/screens/booking_screen.dart';

class BookingCompleteScreen extends StatefulWidget {
  const BookingCompleteScreen({super.key});

  @override
  State<BookingCompleteScreen> createState() => _BookingCompleteScreenState();
}

class _BookingCompleteScreenState extends State<BookingCompleteScreen> {
  @override
  void initState() {
    super.initState();
    // 2 sekund kutib Booking Screen ga o'tish
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BookingScreen(),
          ),
              (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Animation - Check Icon
              TweenAnimationBuilder(
                duration: Duration(milliseconds: 600),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Image.asset('assets/images/complete.png'),
                  );
                },
              ),

              // Success Message
              Text(
                'Payment Complete',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),

              Text(
                'Etiam cras nec metus laoreet. Faucibus',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'iaculis cras ut posuere.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 32),

              // Loading indicator
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2853AF)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}