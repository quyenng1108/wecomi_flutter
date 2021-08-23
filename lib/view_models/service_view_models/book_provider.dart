import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wecomi_flutter/models/book.dart';

class BookProvider with ChangeNotifier {
  List<Book> book = [];
  String errorMessage = '';
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

  Future<List<Book>> fetBook(String bookUuid) async {
    String url =
        "http://117.103.207.22:8082/book/bookGetInfoGeneral?bookuuid=$bookUuid";
    showProgress();
    Response res = await Dio().get(url,
        queryParameters: {
          "BookUUID": bookUuid,
        },
        options: Options(headers: {"Content-Type": "application/json"}));
    book = (res.data as List).map((x) => Book.fromJson(x)).toList();
    // book = List<Book>.from(res.data.map((i) => Book.fromJson(i)));
    notifyListeners();
    dismissProgress();
    return book;
  }
}
