
import 'package:flutter/material.dart';
import 'package:grand_hotel/core/common/widgets/app_bottom_nav_bar.dart';
import 'package:grand_hotel/features/booking/screens/booking_screen.dart';
import 'package:grand_hotel/features/home/screens/home_screen.dart';
import 'package:grand_hotel/features/message/screens/message_screen.dart';
import 'package:grand_hotel/features/profile/screens/profile_screen.dart';
class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const BookingScreen(),
    const MessageScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: isDark? Colors.black12 : Colors.grey.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ]
        ),
        child: AppBottomNavBar(
          currentIndex: _currentIndex,
          onTab: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        ),
      ),
    );
  }
}
