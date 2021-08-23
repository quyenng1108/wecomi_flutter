import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wecomi_flutter/detail_manga/models/comic.dart';

class ComicProvider extends ChangeNotifier {
  List<Comic> comic = <Comic>[];
  List<Comic>? reCommend = [];
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

  Future<List<Comic>?> getComic() async {
    String url = "http://117.103.207.22:8082/book/getMainPage";
    showProgress();
    Response res = await Dio().get(url,
        options: Options(headers: {"Content-Type": "application/json"}));

    if (res.statusCode == 200) {
      comic = (res.data as List).map((x) => Comic.fromJson(x)).toList();
      reCommend = comic.where((i) => i.groupId == "2222222222").toList();
      notifyListeners();
      dismissProgress();
      return reCommend;
    }
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }
}
