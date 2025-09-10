import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grand_hotel/core/routes/app_routers.dart';
import 'package:grand_hotel/features/onboarding/model/onboarding_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  static OnboardingController get to => Get.find();

  final pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingItem> items = [
    const OnboardingItem(
      title: 'Luxury and Comfort, Just a Tap Away',
      description: 'Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem . ',
      image: 'assets/images/onboarding1.png',
    ),
    OnboardingItem(
      title: 'Book with Ease, Stay with Style',
      description: 'Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem . ',
      image: 'assets/images/onboarding2.png',
    ),
    OnboardingItem(
      title: 'Discover Your Dream Hotel, Effortlessly',
      description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      image: 'assets/images/onboarding3.png',
    ),
  ];

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  Future<void> finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Get.offAllNamed(AppRouters.signIn);
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  void previousPage() {
    pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
    super.onClose();
  }
}
