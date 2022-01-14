import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:wecomi_flutter/models/post_comment.dart';
import 'package:wecomi_flutter/models/reply_data.dart';

class CommentProvider extends ChangeNotifier {
  bool isLoading = true;
  List<bool> isGettingMoreReplies = [];

  PostComment? postComment;

  showReplyProgress(int index) {
    if (isGettingMoreReplies[index]) {
      return;
    }
    isGettingMoreReplies[index] = true;
    notifyListeners();
  }

  dismissReplyProgress(int index) {
    if (!isGettingMoreReplies[index]) {
      return;
    }
    isGettingMoreReplies[index] = false;
    notifyListeners();
  }

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

  Future<void> getPostComment(int id) async {
    String url = '${apiUrl}v1/public/posts/$id/comments/';
    showProgress();
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      String response = Utf8Decoder().convert(res.bodyBytes);
      postComment = postCommentFromJson(response);
      isGettingMoreReplies =
          List<bool>.generate(postComment!.results!.length, (bool) => false);
      notifyListeners();
    } else {
      throw Exception(e);
    }
    dismissProgress();
  }

  Future<void> comment(String value) async {
    CommentData data = CommentData(content: value, name: "Thiên Linh");
    // Map body = {
    //     "content": value,
    //     "password": password,
    //   };
    postComment!.results!.add(data);
    notifyListeners();
  }

  Future<void> getMoreReplies(int id, int index) async {
    String url = '${apiUrl}v1/public/comments/$id/reply/';
    showReplyProgress(index);
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      String response = Utf8Decoder().convert(res.bodyBytes);
      ReplyData replyData = replyDataFromJson(response);
      postComment!.results![index].reply!.insertAll(0, replyData.results!);
      notifyListeners();
    }
    dismissReplyProgress(index);
  }
}
