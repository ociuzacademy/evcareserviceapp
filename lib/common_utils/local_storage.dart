import 'package:shared_preferences/shared_preferences.dart';

import 'package:evcareserviceapp/common_utils/preference_keys.dart';

class LocalStorage {
  static Future<void> disableIntroScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isFirstLaunch, false);
  }

  static Future<void> userLogin({
    required String accountType,
    required userId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isLoggedIn, true);
    await preferences.setString(PreferenceKeys.userType, accountType);
    if (accountType == "service_centre") {
      await preferences.setInt(PreferenceKeys.serviceCentreId, userId);
    } else {
      await preferences.setInt(PreferenceKeys.employeeId, userId);
    }
  }

  static Future<void> serviceCentreLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isLoggedIn, false);
    await preferences.remove(PreferenceKeys.userType);
    await preferences.remove(PreferenceKeys.serviceCentreId);
  }

  static Future<void> employeeLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PreferenceKeys.isLoggedIn, false);
    await preferences.remove(PreferenceKeys.userType);
    await preferences.remove(PreferenceKeys.employeeId);
  }

  static Future<bool> getIntroScreenStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isFirstLaunch = preferences.getBool(PreferenceKeys.isFirstLaunch);
    return isFirstLaunch ?? true;
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isLoggedIn = preferences.getBool(PreferenceKeys.isLoggedIn);
    return isLoggedIn ?? false;
  }

  static Future<String> getUserType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userType = preferences.getString(PreferenceKeys.userType);
    return userType ?? "";
  }

  static Future<int> getServiceCentreId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? serviceCentreId = preferences.getInt(PreferenceKeys.serviceCentreId);
    return serviceCentreId ?? 0;
  }

  static Future<int> getEmployeeId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? serviceCentreId = preferences.getInt(PreferenceKeys.employeeId);
    return serviceCentreId ?? 0;
  }
}
