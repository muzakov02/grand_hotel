import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        color: backgroundColor ?? (isDark ? const Color(0xFF1E1E1E) : Colors.white),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTab,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: selectItemColor ?? AppColors.primary,
            unselectedItemColor:
            unselectedItemColor ?? (isDark ? Colors.grey : AppColors.textLight),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            items: [
              _buildNavItem('assets/icons/home.svg', 'assets/icons/home_filled.svg', 'Home', 0),
              _buildNavItem('assets/icons/document.svg', 'assets/icons/document_filled.svg', 'Categories', 1),
              _buildNavItem('assets/icons/chat.svg', 'assets/icons/chat_filled.svg', 'Cart', 2),
              _buildNavItem('assets/icons/user.svg', 'assets/icons/user_filled.svg', 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String iconPath,
      String activeIconPath,
      String label,
      int index,
      ) {
    return BottomNavigationBarItem(
      icon: Builder(
        builder: (context) {
          final isSelected = currentIndex == index;
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : AppColors.primary.withValues(alpha: 0.1))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              isSelected ? activeIconPath : iconPath,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? (AppColors.primary)
                    : (isDark ? Colors.grey : AppColors.textLight),
                BlendMode.srcIn,
              ),
              width: 22,
              height: 22,
            ),
          );
        },
      ),
      label: label,
    );
  }
}
