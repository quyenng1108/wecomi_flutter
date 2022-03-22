import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/models/group_list.dart';
import 'package:http/http.dart' as http;

class GroupListProvider extends ChangeNotifier {
  GroupList? groupList;
  Data? recommederGroupList;
  bool isLoading = true;
  bool isGettingRecommededGroups = true;
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

  Future<void> getGroupList(bool isLogged) async {
    // showProgress();
    if (!isLogged) {
      String url = "${apiUrl}v1/public/groups/";
      var res = await http.get(Uri.parse(url));
      String response = Utf8Decoder().convert(res.bodyBytes);
      groupList = groupListFromJson(response);
      isLoading = false;
      notifyListeners();
    } else {
      String url = "${apiUrl}v1/groups/";
      Map<String, String> header = {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": AppSession().token!
      };
      var res = await http.get(Uri.parse(url), headers: header);
      String response = Utf8Decoder().convert(res.bodyBytes);
      groupList = groupListFromJson(response);
      isLoading = false;
      notifyListeners();
    }
    // dismissProgress();
  }

  Future<void> getRecommendedGroupList(bool isLogged) async {
    if (!isLogged) {
      // String url = "${apiUrl}v1/public/groups/";
      // var res = await http.get(Uri.parse(url));
      // String response = Utf8Decoder().convert(res.bodyBytes);
      // groupList = groupListFromJson(response);
      // isGettingRecommededGroups = false;
      // notifyListeners();
    } else {
      String url = "${apiUrl}v1/groups/recommender/";
      Map<String, String> header = {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": AppSession().token!
      };
      var res = await http.get(Uri.parse(url), headers: header);
      String response = Utf8Decoder().convert(res.bodyBytes);
      recommederGroupList = dataFromJson(response);
      isGettingRecommededGroups = false;
      notifyListeners();
    }
  }
}
