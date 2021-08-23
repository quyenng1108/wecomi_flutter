import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wecomi_flutter/models/book_detail.dart';

class BookDetailProvider with ChangeNotifier {
  List<BookDetail> bookDetailList = [];
  String url = '';
  Future<void> getBookDetail() async {
    final parameter = {
      "bookuuid": "9B7FCE36-4C62-4C05-A4FB-030E827DDBF2",
      "sortBy" : "0"
    };
    Uri uri = Uri.http('117.103.207.22:8082', '/book/bookGetChapterInfo',parameter);
    var response = await http.get(uri);
    bookDetailList = bookDetailFromJson(response.body);
    notifyListeners();
  }
}
