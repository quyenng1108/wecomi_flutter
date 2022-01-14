import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wecomi_flutter/constants/api.dart';
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

  Future<void> getChapterData(int chapterId, int choice) async {
    showProgress();

    String url = "${apiUrl}v1/public/chapters/$chapterId";
    Uri uri = Uri.parse(url);
    var response = await http.get(
      uri,
    );
    print(uri);
    var res = Utf8Decoder().convert(response.bodyBytes);
    Chapter chapterData = chapterFromJson(res);
    // chapterList = chapterToList(response.body);
    if (chapterData.images!.length == 0 || chapterData.images!.isEmpty) {
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
