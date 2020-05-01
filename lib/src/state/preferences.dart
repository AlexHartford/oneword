import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey { HIDE_ACCOUNT_SECURITY_BANNER }

class Preferences {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // TODO: Dynamic value param for map
  Future<Map<PrefKey, String>> get map async {
    final prefs = await _prefs;
    return Map.fromIterable(
      prefs.getKeys(),
      key: (key) => key,
      value: (key) => prefs.getString(key)
    );
  }

  getFlag(PrefKey key) async {
    final prefs = await _prefs;
    return prefs.getBool(key.toString());
  }

  setFlag(PrefKey key, bool flag) async {
    final prefs = await _prefs;
    prefs.setBool(key.toString(), flag);
  }

  setPreference(PrefKey key, String value) async {
    final prefs = await _prefs;
    prefs.setString(key.toString(), value);
  }
}