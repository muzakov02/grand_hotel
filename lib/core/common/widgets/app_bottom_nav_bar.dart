import 'package:flutter/material.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTab;
  final Color? backgroundColor;
  final Color? selectItemColor;
  final Color? unselectedItemColor;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTab,
    this.backgroundColor,
    this.selectItemColor,
    this.unselectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? (isDark ? Color(0xFF1E1E1E) : Colors.white),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ]),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTab,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: selectItemColor ?? AppColors.primary,
            unselectedItemColor: unselectedItemColor ??
                (isDark ? Colors.grey : AppColors.textLight),
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            items: [
              _buildNavItem(Icons.home_rounded, 'Home', 0),
              _buildNavItem(Icons.category_rounded, 'Categories', 1),
              _buildNavItem(Icons.shopping_cart, 'Cart', 2),
              _buildNavItem(Icons.person, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon,
      String label,
      int index,
      ) {
    return BottomNavigationBarItem(icon: Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: currentIndex == index
                ? (isDark
                ? AppColors.primary.withValues(alpha: 0.2)
                : AppColors.primary.withValues(alpha: 0.1))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon),
        );
      },
    ),
      label: label,
    );
  }
}
