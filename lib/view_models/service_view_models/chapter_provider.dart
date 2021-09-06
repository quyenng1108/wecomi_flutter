import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wecomi_flutter/models/chapter_model.dart';

class ChapterProvider with ChangeNotifier {
  // Chapter chapterData = Chapter();
  List<Chapter> chapterList = [];
  bool isLoading = true;
  bool isVisible = true;
  int titleIndex = 0;
  List<GlobalKey>? key;
  bool? flag;
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

  showAppBar() {
    if (isVisible) {
      return;
    }
    isVisible = true;

    notifyListeners();
  }

  dismissAppBar() {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    notifyListeners();
  }

  setTitleIndex(int index) {
    titleIndex = index;
    notifyListeners();
  }

  removeChapterList() {
    showProgress();
    chapterList.clear();
    titleIndex = 0;
    notifyListeners();
  }

  Future<void> getChapterData(String chapterId, int choice) async {
    showProgress();
    Map body = {
      "chapterId": chapterId,
      "accountId": 10008,
      "accessToken": "637639682306900000.d6301b8d58ba9278a7bf36172e31944d",
      "pageNo": 1,
      "rowsOfPage": 1000
    };
    String url = "http://117.103.207.22:8082/book/bookGetdataBychapterId";
    Uri uri = Uri.parse(url);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));
    Chapter chapterData = chapterFromJson(response.body);
    // chapterList = chapterToList(response.body);
    if (chapterData.data!.length == 0 || chapterData.data!.isEmpty) {
      flag = false;
      dismissProgress();
    } else {
      if (choice == 0) {
        chapterList.add(chapterData);
      } else if (choice == 1) {
        chapterList.insert(0, chapterData);
        print("hi");
        print(chapterList.length);
      } else if (choice == 2) {
        chapterList.insert(chapterList.length, chapterData);
      }
      key = List.generate(chapterList.length, (index) => GlobalKey());
      // print(chapterList.length);
      flag = true;
      dismissProgress();
    }
  }
}
