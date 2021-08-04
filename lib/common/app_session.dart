import 'package:shared_preferences/shared_preferences.dart';

class AppSession{
  String? token;
  String? name;
  String? avatar;
  int? userId;
  int? accountStatus;
  List<String>? userData;
  int sex = 2;
  static final AppSession _shared = new AppSession._internal();
  factory AppSession() {
    return _shared;
  }
  AppSession._internal();

    Future<void> saveSession() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    print(token);
    List<String>? userData = prefs.getStringList("userData");
    if(token != null && userData != null){
    userId = int.parse(userData[0]);
    accountStatus = int.parse(userData[1]);
    if(prefs.getInt("sex") != null){
      sex = prefs.getInt("sex")!; 
    }
    }
  }

  Future<void> logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = null;
    userId = null;
    accountStatus = null;
    await prefs.remove("token");
    await prefs.remove("userData");
  }

  Future<void> changeSexGroup(int sexGroup) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("sex", sexGroup);
    sex = sexGroup;
  }
}