import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = new Preferences._();

  static const USER_TOKEN = "USER_TOKEN";
  static const CURRENT_USER = "CURRENT_USER";
  static const APP_MODEL = "APP_MODEL";

  factory Preferences() => _instance;

  Preferences._();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  removeUser() async {
    await _prefs.remove(USER_TOKEN);
    await _prefs.remove(CURRENT_USER);
  }

  set userLogged(String value) => _prefs.setString(CURRENT_USER, value);

  get userLogged => _prefs?.getString(CURRENT_USER) ?? '';

  set userToken(String value) => _prefs.setString(USER_TOKEN, value);

  get userToken => _prefs?.getString(USER_TOKEN) ?? '';

  set appModel(String value) => _prefs.setString(APP_MODEL, value);

  get appModel => _prefs?.getString(APP_MODEL) ?? '';
}
