import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:wecomi_flutter/models/group_post.dart';

class GroupInfoProvider extends ChangeNotifier {
  GroupPost? groupPost;
  bool isLoading = true;

  Future<void> getGroupPost(int id) async {
    String url = "${apiUrl}v1/public/groups/$id/post_group/";
    var res = await http.get(Uri.parse(url));
    String response = Utf8Decoder().convert(res.bodyBytes);
    groupPost = groupPostFromJson(response);
    isLoading = false;
    notifyListeners();
  }
}
