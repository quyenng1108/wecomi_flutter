import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/constants/utils.dart';
import 'package:wecomi_flutter/models/comics.dart';
import 'package:wecomi_flutter/models/followed_book.dart';
import 'package:wecomi_flutter/models/followed_book_model.dart';
import 'package:http/http.dart' as http;

class FollowBookProvider extends ChangeNotifier {
  ComicByCategory? followedBook = ComicByCategory();
  List<FollowedBook> followedBookList = [];
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

  Future<void> getFollowedBookList(String token) async {
    String url = "${apiUrl}v1/follow/book_follow";
    Uri uri = Uri.parse(url);
    showProgress();
    final res = await http.get(uri, headers: {"Authorization": token});
    if (res.statusCode == 200) {
      final response = Utf8Decoder().convert(res.bodyBytes);
      followedBook = comicByCategoryFromJson(response);
      // print(followedBook?.results?[0].id);
      notifyListeners();
    } else {
      throw Exception(e);
    }
    dismissProgress();
  }

  void loadFollowedBook() {
    showProgress();
    var box = Utils.getFollowedBook();
    followedBookList = box.values.cast<FollowedBook>().toList();
    notifyListeners();
    dismissProgress();
  }

  void followBook(FollowedBook followedBook) {
    var box = Utils.getFollowedBook();
    bool hasBookExisted = false;
    int index = 0;
    if (followedBookList.isNotEmpty) {
      for (int i = 0; i < followedBookList.length; i++) {
        if (followedBook.bookId == followedBookList[i].bookId) {
          hasBookExisted = true;
          index = i;
          break;
        }
      }
      if (hasBookExisted) {
        followedBookList.removeAt(index);
        followedBookList.add(followedBook);
        box.deleteAt(index);
        box.add(followedBook);
      } else {
        followedBookList.add(followedBook);
        box.add(followedBook);
      }
    } else {
      followedBookList.add(followedBook);
      box.add(followedBook);
    }
    notifyListeners();
  }

  void unfollowBook(int index) {
    var box = Utils.getFollowedBook();
    followedBookList.removeAt(index);
    box.deleteAt(index);
    notifyListeners();
  }
}
