import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Map<String, String>> get map async {
    final prefs = await _prefs;
    return Map.fromIterable(
      prefs.getKeys(),
      key: (key) => key,
      value: (key) => prefs.getString(key)
    );
  }

  setPreference(String key, String value) async {
    final prefs = await _prefs;
    prefs.setString(key, value);
  }
}