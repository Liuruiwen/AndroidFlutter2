import 'package:shared_preferences/shared_preferences.dart';

/**
 * Created by Amuser
 * Date:2020/1/10.
 * Desc:内存储
 */
class SpUntil {
  /**
   * ================存储的key  start============
   */
  static String SP_LOGIN = "sp_login";

  /**
   * ================存储的key  end============
   */

  // 工厂模式
  factory SpUntil() => _getInstance();

  static SpUntil get instance =>  _getInstance();
  static SpUntil _instance;

  SpUntil._internal() {
    // 初始化

//    _getSpInstance();
  }

  static SpUntil _getInstance() {

    if (_instance == null) {
      _instance = new SpUntil._internal();
    }
    return _instance;
  }

   SharedPreferences get spInstance => _spInstance;
    SharedPreferences _spInstance;

   getSpInstance() async {
    if (_spInstance == null) {
      _spInstance = await SharedPreferences.getInstance();
    }
    return _spInstance;
    ;
  }

  ///=============存================
  spString(String key, String value) async{
    spInstance.setString(key, value);
  }

  spBool(String key, bool value) {
    spInstance.setBool(key, value);
  }

  spInt(String key, int value) {
    spInstance.setInt(key, value);
  }

  spDouble(String key, double value) {
    spInstance.setDouble(key, value);
  }

  spStringList(String key, List<String> value) {
    spInstance.setStringList(key, value);
  }

  ///=============取================
  Future<String> getSpString(String key) async{
    return spInstance.get(key) ?? null;
  }

  bool getSpBool(String key) {
    return spInstance.getBool(key);
  }

  int getSpInt(String key) {
    return spInstance.getInt(key);
  }

  double getSpDouble(String key) {
    return spInstance.getDouble(key);
  }

  List<String> getSpStringList(String key) {
    return spInstance.getStringList(key);
  }
  ///==============清除====================
   Future<bool> spClear(String key) async{
    return spInstance.remove(key);
  }
}
