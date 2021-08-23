import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wecomi_flutter/detail_manga/models/getchapter_byBookuuid_provider.dart';

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
        queryParameters: {
          "BookUUID": bookUuid,
        },
        options: Options(headers: {"Content-Type": "application/json"}));
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
