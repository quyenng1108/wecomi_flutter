import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/models/book_by_category.dart';
import 'package:http/http.dart' as http;
import 'package:wecomi_flutter/models/comics.dart';
import 'package:wecomi_flutter/models/hot_keyword_model.dart';
import 'package:wecomi_flutter/views/search/search_screen.dart';

class SearchProvider with ChangeNotifier {
  ComicByCategory? searchResult;
  HotKeyword? hotKeyword;
  List<String> history = [];
  bool isLoading = true;
  String _key = "";
  String get key => _key;
  int? bubbleIndex;

  List<String> matchingWords = [];
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

  setKeyWord(String value) {
    _key = value;
    notifyListeners();
  }

  splitString(String string) {
    matchingWords = string.split(' ');
    notifyListeners();
  }

  void clearSearch() {
    _key = "";
    notifyListeners();
  }

  void getHotKeyword() async {
    String url = "${apiUrl}v1/history-search/trend/";
    var uri = Uri.parse(url);
    var res = await http.get(uri);
    if (res.statusCode == 200) {
      String response = Utf8Decoder().convert(res.bodyBytes);
      hotKeyword = hotKeywordFromJson(response);
      notifyListeners();
    } else {
      print("ko co gi ca");
    }
  }

  void search(String keyword) async {
    final params = {'params': keyword};
    var uri = Uri.http(apiNoHttp, "/v1/public/books/search", params);
    matchingWords = [];
    _key = keyword;
    if (keyword != "") {
      showProgress();
      splitString(keyword);
      print(matchingWords);
      var res = await http.get(uri);
      String response = Utf8Decoder().convert(res.bodyBytes);

      // var res = await http.post(uri,
      //     body: json.encode(data),
      //     headers: {"Content-Type": "application/json"});
      // searchResult = List<BooksByCategory>.from(
      //     res.body.map((i) => BooksByCategory.fromJson(i)));

      searchResult = comicByCategoryFromJson(response);
      print(searchResult);
      notifyListeners();
      dismissProgress();
    } else {
      print("Error");
      notifyListeners();
    }
  }

  void saveSearchHistory(String keyword) async {
    int tmp = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (history.length < 5) {
      for (int i = 0; i < history.length; i++) {
        if (keyword == history[i]) {
          history.removeAt(i);
          history.insert(0, keyword);
          tmp++;
          break;
        }
      }
      if (tmp == 0) {
        history.insert(0, keyword);
        prefs.setStringList("history", history);
      }
    } else if (history.length == 5) {
      for (int i = 0; i < history.length; i++) {
        if (keyword == history[i]) {
          history.removeAt(i);
          history.insert(0, keyword);
          tmp++;
          break;
        }
      }
      if (tmp == 0) {
        history.removeAt(4);
        history.insert(0, keyword);
        prefs.setStringList("history", history);
      }
    }
  }

  void loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("history") != null) {
      history = prefs.getStringList("history")!;
      print(history);
    } else {
      history = [];
    }
    notifyListeners();
  }

  void clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    history = [];
    prefs.setStringList("history", history);
    notifyListeners();
  }

  void deleteSearchHistory(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    history.removeAt(index);
    prefs.setStringList("history", history);
  }
}
