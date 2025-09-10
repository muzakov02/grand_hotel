import 'package:get/get.dart';
import 'package:grand_hotel/core/routes/app_routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController{
  static SplashController get to => Get.find();

  Future<String> determineInitialRoute() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final isFirstTime = prefs.getBool('isFirstTime') ?? true;

      if(isFirstTime){
        return AppRouters.onboarding;
      }
      return AppRouters.signIn;
    } catch (e){
      print('Error determining initial route: $e');
      return AppRouters.signIn;
    }
  }
}