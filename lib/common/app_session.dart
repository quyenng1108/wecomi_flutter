import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  String? token;
  String? name;
  String? avatar;
  int? userId;
  int? accountStatus;
  List<String>? userData;
  int sex = 2;
  String? username;
  String? password;
  bool usingLocalAuth = false;
  static final AppSession _shared = new AppSession._internal();
  factory AppSession() {
    return _shared;
  }
  AppSession._internal();

  Future<void> saveSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    List<String>? userData = prefs.getStringList("userData");
    if (token != null && userData != null) {
      name = userData[0];
      // userId = int.parse(userData[0]);
      // accountStatus = int.parse(userData[1]);
      if (prefs.getInt("sex") != null) {
        sex = prefs.getInt("sex")!;
      }
    }
  }

  Future<void> saveLoginData(String name, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = name;
    password = pass;
    prefs.setStringList("loginData", [name, pass]);
  }

  Future<void> saveLocalAuthStatus(bool isUsingLocalAuth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usingLocalAuth = isUsingLocalAuth;
    prefs.setBool("usingLocalAuthStatus", isUsingLocalAuth);
  }

  Future<void> getLocalAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("usingLocalAuthStatus") != null) {
      bool isUsingLocalAuth = prefs.getBool("usingLocalAuthStatus")!;
      usingLocalAuth = isUsingLocalAuth;
    }
  }

  Future<void> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? loginData = prefs.getStringList("loginData");
    if (loginData != null) {
      username = loginData[0];
      password = loginData[1];
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = null;
    userId = null;
    name = null;
    accountStatus = null;
    await prefs.remove("token");
    await prefs.remove("userData");
  }

  Future<void> changeSexGroup(int sexGroup) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("sex", sexGroup);
    sex = sexGroup;
  }
}
