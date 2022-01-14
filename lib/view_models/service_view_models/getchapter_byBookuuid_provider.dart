import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/models/getchapter_byBookuuid.dart';

class ChapterByBookIDProvider extends ChangeNotifier {
  ChapterByBookUuid chapterByBookId = ChapterByBookUuid();
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

  Future<void> getChapterByBookId(int id) async {
    String url = "${apiUrl}v1/public/books/$id";
    print(url);
    showProgress();
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      String response = Utf8Decoder().convert(res.bodyBytes);

      chapterByBookId = chapterByBookUuidFromJson(response);
      print(res.body);
      notifyListeners();
    } else {
      throw Exception(e);
    }
    dismissProgress();
  }
}
