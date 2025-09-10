import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';
import 'package:grand_hotel/features/splash/controllers/splash_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    // ❗️ vaqtinchalik: onboardingni qayta test qilish uchun
    _resetOnboarding();

    _handleNavigation();
  }

  /// Vaqtinchalik: Onboardingni qayta ochilishi uchun flagni o‘chiradi
  Future<void> _resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('seenOnboarding');
  }

  /// Splash tugagach qaysi sahifaga o‘tishni aniqlash
  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;

    final route = await SplashController.to.determineInitialRoute();
    Get.offAllNamed(route);
  }

  /// Animatsiyalarni sozlash
  void _setupAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation = Tween<double>(begin: -30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => _buildAnimatedContent(isDark),
        ),
      ),
    );
  }

  Widget _buildAnimatedContent(bool isDark) {
    return Transform.translate(
      offset: Offset(0, _slideAnimation.value),
      child: Transform.rotate(
        angle: _rotateAnimation.value,
        child: Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: _buildSplashContent(isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildSplashContent(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogoContainer(),
        const SizedBox(height: 24),
        _buildAppTitle(),
        const SizedBox(height: 8),
        _buildAppSubtitle(),
      ],
    );
  }

  Widget _buildLogoContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/splash_image.png',
        width: 90,
        height: 123,
      ),
    );
  }

  Widget _buildAppTitle() {
    return const Text(
      'Grand Hotel',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

  Widget _buildAppSubtitle() {
    return Text(
      'Find Your Perfect Stay, Anytime, Anywhere',
      style: TextStyle(
        fontSize: 14,
        color: Colors.white.withValues(alpha: 0.7),
        letterSpacing: 0.5,
      ),
    );
  }
}
