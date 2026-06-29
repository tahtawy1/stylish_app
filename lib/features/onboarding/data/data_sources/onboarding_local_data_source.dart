import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_app/core/error/exceptions.dart';

class OnboardingLocalDataSource {
  final SharedPreferences prefs;
  OnboardingLocalDataSource({required this.prefs});

  bool isOnboardingSeen() {
    try {
      return prefs.getBool('is_first_open') ?? false;
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> saveOnboardingSeen() async {
    try {
      await prefs.setBool('is_first_open', true);
    } catch (e) {
      throw CacheException();
    }
  }
}
