import 'package:qatar_quran_memorization/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum prefKeys {
  loggedIn,
  id,
  name,
  identification,
  groupname,
}

class SharedPrefController {
  SharedPrefController._internal();

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._internal();
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required User user}) async {
    await _sharedPreferences.setBool(prefKeys.loggedIn.name, true);
    await _sharedPreferences.setInt(prefKeys.id.name, user.id);
    await _sharedPreferences.setString(prefKeys.name.name, user.name);
    await _sharedPreferences.setString(prefKeys.groupname.name, user.groupName);
    await _sharedPreferences.setInt(
        prefKeys.identification.name, user.identificationNumber);
  }

  bool get loggedIn =>
      _sharedPreferences.getBool(prefKeys.loggedIn.name) ?? false;

  String? get name =>
       _sharedPreferences.getString(prefKeys.name.name);
  String? get groupname =>
      _sharedPreferences.getString(prefKeys.groupname.name);
//or this
  T? getValueFor<T>({required String key}) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }
  Future<void> logout() async {
    _sharedPreferences.setBool(prefKeys.loggedIn.name, false);
  }
}
