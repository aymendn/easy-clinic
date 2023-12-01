import 'package:shared_preferences/shared_preferences.dart';


enum PrefsKey {
  placeHolder,
}

class Prefs {
  Prefs._();

  static late SharedPreferences instance;

  static Future<SharedPreferences> init() async {
    instance = await SharedPreferences.getInstance();
    return instance;
  }



}
