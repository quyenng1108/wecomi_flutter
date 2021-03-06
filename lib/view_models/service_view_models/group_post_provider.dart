import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/models/group_post.dart';
import 'package:http/http.dart' as http;

class GroupPostProvider extends ChangeNotifier {
  bool isLoading = true;
  GroupPost? groupPost;
  List<bool> isLiked = [];

  bool test = false;

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

  Future<void> getGroupPosts() async {
    String url = "${apiUrl}v1/public/posts/post_trending/";
    showProgress();
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      String response = Utf8Decoder().convert(res.bodyBytes);
      groupPost = groupPostFromJson(response);
      isLiked =
          List<bool>.generate(groupPost!.results!.length, (isLike) => false);
      notifyListeners();
    } else {
      throw Exception(e);
    }
    dismissProgress();
  }

  testPressed() {
    test = !test;
    notifyListeners();
  }

  likePressed(int index) {
    isLiked[index] = !isLiked[index];
    notifyListeners();
  }

  commentAdded(int index) {
    groupPost!.results![index].commentCount =
        groupPost!.results![index].commentCount! + 1;
  }

  like(int index, bool isLike, int postId) async {
    Map<String, dynamic> body = {"type_like": "post", "book": "", "comment": "", "post": postId};
    Map<String, String> header = {"Content-type": "application/json", "Accept": "application/json", "Authorization": AppSession().token!};
    String url = "${apiUrl}v1/follow/like/";
    if (!isLike) {
      groupPost!.results![index].likeCount =
          groupPost!.results![index].likeCount! + 1;
    } else {
      groupPost!.results![index].likeCount =
          groupPost!.results![index].likeCount! - 1;
    }
    var res = await http.post(Uri.parse(url),
        headers: header, body: json.encode(body));
    print(res.body);
    notifyListeners();
  }
}
