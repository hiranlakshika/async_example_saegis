import 'package:shared_preferences/shared_preferences.dart';

enum DateTypeEnum { Integer, String, Double, Boolean, StringList }

class SharedPreferencesHelper {
  static Future<void> saveValue({required String key, required var value, required DateTypeEnum dataType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (dataType) {
      case DateTypeEnum.Integer:
        await prefs.setInt(key, value);
        break;
      case DateTypeEnum.String:
        await prefs.setString(key, value);
        break;
      case DateTypeEnum.Double:
        await prefs.setDouble(key, value);
        break;
      case DateTypeEnum.Boolean:
        await prefs.setBool(key, value);
        break;
      case DateTypeEnum.StringList:
        await prefs.setStringList(key, value);
        break;
    }
  }

  static Future<dynamic> getValues({required String key, required DateTypeEnum dataType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (dataType) {
      case DateTypeEnum.Integer:
        return prefs.getInt(key);
      case DateTypeEnum.String:
        return prefs.getString(key);
      case DateTypeEnum.Double:
        return prefs.getDouble(key);
      case DateTypeEnum.Boolean:
        return prefs.getBool(key);
      case DateTypeEnum.StringList:
        return prefs.getStringList(key);
    }
  }

  static Future<void> deleteValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
