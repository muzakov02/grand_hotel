import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grand_hotel/core/common/widgets/custom_button.dart';
import 'package:grand_hotel/core/config/theme/app_colors.dart';
import 'package:grand_hotel/features/onboarding/controller/onboarding_controller.dart';
import 'package:grand_hotel/features/onboarding/model/onboarding_item.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.items.length,
        onPageChanged: controller.onPageChanged,
        itemBuilder: (context, index) {
          final isLast = index == controller.items.length - 1;
          return _buildPage(context, controller.items[index], index,
              isLastPage: isLast);
        },
      ),
    );
  }

  Widget _buildPage(
    BuildContext context,
    OnboardingItem item,
    int pageIndex, {
    bool isLastPage = false,
  }) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(item.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black87],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Title
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 14),

            // Description
            Text(
              item.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.normal,
                  ),
            ),

            SizedBox(height: isLastPage ? 40 : 32),

            if (!isLastPage) ...[
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.items.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      height: 8,
                      width: controller.currentPage.value == i ? 24 : 8,
                      decoration: BoxDecoration(
                        color: controller.currentPage.value == i
                            ? AppColors.primary
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 44),
            ],

            // Button
            SizedBox(
              width: width * 0.85,
              child: CustomButton(
                text: isLastPage ? 'Get Started' : 'Continue',
                onPressed: isLastPage
                    ? controller.finishOnboarding
                    : controller.nextPage,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
              ),
            ),

            if (isLastPage) ...[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Register sahifaga o'tkazish
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
