import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:wecomi_flutter/models/user_profile.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfile? userProfile;
  bool hasFollowed = false;
  bool isLoading = true;

  showProgress() {
    if (isLoading) {
      return;
    }
    isLoading = true;
    notifyListeners();
  }

  dismissProgress() {
    if (!isLoading) {
      return;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getUserProfile(int id) async {
    String url = '${apiUrl}v1/public/user-profile/$id/';
    showProgress();
    Uri uri = Uri.parse(url);
    dynamic res = await http.get(uri);
    if (res.statusCode == 200) {
      String response = Utf8Decoder().convert(res.bodyBytes);
      userProfile = userProfileFromJson(response);
      print(userProfile);
      notifyListeners();
    } else {
      throw Exception(e);
    }
    dismissProgress();
  }

  void follow() {
    hasFollowed = !hasFollowed;
    notifyListeners();
  }
}
