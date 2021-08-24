import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:get_ip_address/get_ip_address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecomi_flutter/models/account_model.dart';

class LoginProvider with ChangeNotifier {
  AccountModel _loggedInAccount = AccountModel(null, null, null, null);
  AccountModel _invalidUsernameAccount = AccountModel(null, null, null, null);
  AccountModel _invalidPasswordAccount = AccountModel(null, null, null, null);
  AccountModel get loggedInaccount => _loggedInAccount;
  AccountModel get invalidUsernameAccount => _invalidUsernameAccount;
  AccountModel get invalidPasswordAccount => _invalidPasswordAccount;
  String? accessToken;
  int? userId;
  int? accountStatus;

  Future<void> loginWithEmail(
      String username, String password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loggedInAccount = AccountModel(null, null, null, null);
    _invalidUsernameAccount = AccountModel(null, null, null, null);
    _invalidPasswordAccount = AccountModel(null, null, null, null);
    String url =
        "http://117.103.207.22:8082/account/accountAuthenticate_localAccount";
    try {
      var ipAddress = IpAddress(type: RequestType.text);
      dynamic ipData = await ipAddress.getIpAddress();
      Map body = {
        "accountName": username,
        "accountPass": password,
        "clientIp": ipData
      };
      print(body);
      final uri = Uri.parse(url);
      final res = await http.post(uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));
      var jsonResponse = json.decode(res.body);
      print(res.body.toString());
      if (jsonResponse["responseStatus"] == 1) {
        // _loggedInAccount = AccountModel(
        //     jsonResponse["accessToken"], jsonResponse["accountId"], null, null);
        prefs.setString("token", jsonResponse["accessToken"]);
        prefs.setStringList("userData", [
          jsonResponse["accountId"].toString(),
          jsonResponse["accountStatus"].toString()
        ]);
        Navigator.pop(context);
        Navigator.pop(context);
      } else if (jsonResponse["responseStatus"] == -50) {
        _invalidUsernameAccount =
            AccountModel(null, null, "Tài khoản không tồn tại", null);

        print(_invalidUsernameAccount.invalidUsernameMessage);
        // print(invalidUsername);
      } else {
        _invalidPasswordAccount =
            AccountModel(null, null, null, "Mật khẩu không đúng");
        // print(invalidPassword);
      }
    } on IpAddressException catch (exception) {
      /// Handle the exception.
      print(exception.message);
    }
    notifyListeners();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<void> loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      String email = googleSignInAccount.email;
      print(email);
      String accessTokenGG = googleSignInAuthentication.accessToken!;
      print(accessTokenGG);
    } else {
      print("loi rui`");
      return null;
    }
    notifyListeners();
  }

  Future<void> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        AccessToken accessToken = result.accessToken!;
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${accessToken.token}'));
        final userData = jsonDecode(graphResponse.body);
        print(accessToken.token);
        print(userData);
        break;
      case LoginStatus.cancelled:
        print("login cancelled");
        break;
      case LoginStatus.failed:
        print("login failed");
        break;
      case LoginStatus.operationInProgress:
        print("login in progress");
    }
    notifyListeners();
  }

  checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString("token");
    notifyListeners();
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = null;
    await prefs.remove("token");
    notifyListeners();
  }
}
