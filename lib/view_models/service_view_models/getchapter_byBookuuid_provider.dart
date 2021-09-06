import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wecomi_flutter/models/getchapter_byBookuuid.dart';

class ChapterByBookIDProvider extends ChangeNotifier {
  List<ChapterByBookUuid> chapterByBookId = [];
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

  Future<List<ChapterByBookUuid>> getChapterByBookId(String bookUuid) async {
    String url =
        "http://117.103.207.22:8082/book/bookGetChapterInfo?bookuuid=$bookUuid";
    showProgress();
    Response res = await Dio().get(url,
        options: Options(headers: {"Content-Type": "application/json"}),queryParameters: {
      "bookuuid": bookUuid,
      "sortBy" : "0"
    }
        );
    if (res.statusCode == 200) {
      chapterByBookId =
          (res.data as List).map((x) => ChapterByBookUuid.fromJson(x)).toList();
      notifyListeners();
    } else {
      throw Exception(e);
    }
    dismissProgress();
    return chapterByBookId;
  }
}
