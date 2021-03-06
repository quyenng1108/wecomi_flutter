import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:get_ip_address/get_ip_address.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/models/account_model.dart';
import 'package:wecomi_flutter/models/user_profile.dart';
import 'package:wecomi_flutter/view_models/service_view_models/follow_book_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/local_auth_provider.dart';

class LoginProvider with ChangeNotifier {
  AccountModel _loggedInAccount = AccountModel(null, null, null, null);
  AccountModel _invalidUsernameAccount = AccountModel(null, null, null, null);
  AccountModel _invalidPasswordAccount = AccountModel(null, null, null, null);
  AccountModel get loggedInaccount => _loggedInAccount;
  AccountModel get invalidUsernameAccount => _invalidUsernameAccount;
  AccountModel get invalidPasswordAccount => _invalidPasswordAccount;
  String? accessToken;
  UserProfile userProfile = UserProfile();
  int? userId;
  int? accountStatus;
  String? accountName;
  String? avatar;
  bool isLogged = false;

  Future<void> loginWithEmail(
      String username, String password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loggedInAccount = AccountModel(null, null, null, null);
    _invalidUsernameAccount = AccountModel(null, null, null, null);
    _invalidPasswordAccount = AccountModel(null, null, null, null);
    String url = "${apiUrl}login";
    try {
      var ipAddress = IpAddress(type: RequestType.text);
      // dynamic ipData = await ipAddress.getIpAddress();
      Map body = {
        "username": username,
        "password": password,
      };
      print(body);
      final uri = Uri.parse(url);
      final res = await http.post(uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));
      var jsonResponse = json.decode(res.body);
      print(res.body.toString());
      if (res.statusCode == 200) {
        // _loggedInAccount = AccountModel(
        //     jsonResponse["accessToken"], jsonResponse["accountId"], null, null);
        prefs.setString("token", jsonResponse["access_token"]);

        // Provider.of<FollowBookProvider>(context, listen: false)
        //     .getFollowedBookList(jsonResponse["access_token"]);
        if (username != AppSession().username) {
          Provider.of<LocalAuthProvider>(context, listen: false)
              .onLogout(false);
        }
        AppSession().saveLoginData(username, password);
        getUserProfile(jsonResponse["access_token"]).then((value) {
          prefs.setStringList("userData", [
            userProfile.fullName ?? '',
            "${userProfile.avatar!}",
            userProfile.id.toString()
          ]);
          checkLoginState();
          Navigator.pop(context);
          Navigator.pop(context);
        });
        // Navigator.pop(context);
        // Navigator.pop(context);
      } else if (res.statusCode == 400) {
        _invalidUsernameAccount =
            AccountModel(null, null, "T??i kho???n kh??ng t???n t???i", null);
        print(_invalidUsernameAccount.invalidUsernameMessage);
        Navigator.pop(context);

        // print(invalidUsername);
      } else {
        _invalidPasswordAccount =
            AccountModel(null, null, null, "M???t kh???u kh??ng ????ng");
        Navigator.pop(context);
        // print(invalidPassword);
      }
    } on IpAddressException catch (exception) {
      /// Handle the exception.
      print(exception.message);
    }
    notifyListeners();
  }

  Future<void> getUserProfile(String token) async {
    String url = '${apiUrl}v1/user-profile/user_info/';
    // showProgress();
    Uri uri = Uri.parse(url);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": token
    };
    dynamic res = await http.get(uri, headers: header);
    if (res.statusCode == 200) {
      String response = Utf8Decoder().convert(res.bodyBytes);
      userProfile = userProfileFromJson(response);
      print(userProfile);
      notifyListeners();
    } else {
      throw Exception(e);
    }
    // dismissProgress();
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

  // Future<void> loginWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   switch (result.status) {
  //     case LoginStatus.success:
  //       AccessToken accessToken = result.accessToken!;
  //       final graphResponse = await http.get(Uri.parse(
  //           'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${accessToken.token}'));
  //       final userData = jsonDecode(graphResponse.body);
  //       print(accessToken.token);
  //       print(userData);
  //       break;
  //     case LoginStatus.cancelled:
  //       print("login cancelled");
  //       break;
  //     case LoginStatus.failed:
  //       print("login failed");
  //       break;
  //     case LoginStatus.operationInProgress:
  //       print("login in progress");
  //   }
  //   notifyListeners();
  // }

  checkLoginState() async {
    AppSession().saveSession().then((value) {
      if (AppSession().token == null) {
        isLogged = false;
      } else {
        isLogged = true;
        accountName = AppSession().name;
        avatar = "${apiUrlNoSlash}${AppSession().avatar}";
        userId = AppSession().userId;
      }
    });

    notifyListeners();
  }

  setAvatar(String avatarUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    avatar = "$apiUrlNoSlash$avatarUrl";
    notifyListeners();
    print(avatar);
    prefs.setStringList("userData", [
      AppSession().name ?? "",
      "$avatarUrl",
      AppSession().userId.toString()
    ]);
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppSession().logout();
    isLogged = false;
    notifyListeners();
  }
}
