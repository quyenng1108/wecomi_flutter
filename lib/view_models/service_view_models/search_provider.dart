import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecomi_flutter/models/book_by_category.dart';
import 'package:http/http.dart' as http;
import 'package:wecomi_flutter/models/hot_keyword_model.dart';
import 'package:wecomi_flutter/views/search/search_screen.dart';

class SearchProvider with ChangeNotifier {
  List<BooksByCategory> searchResult = [];
  List<HotKeyword> hotKeyword = [];
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
    String url = "http://117.103.207.22:8082/book/bookSearchKeywordTrending";
    var uri = Uri.parse(url);
    var res = await http.get(uri);
    if (res.statusCode == 200) {
      hotKeyword = hotKeywordFromJson(res.body);
      notifyListeners();
    } else {
      print("ko co gi ca");
    }
  }

  void search(String keyword, int id) async {
    Map data = {"searchWord": keyword, "categoryId": id};
    String url = "http://117.103.207.22:8082/book/bookSearchPageKeyword";
    var uri = Uri.parse(url);
    matchingWords = [];
    _key = keyword;
    if (keyword != "") {
      showProgress();
      splitString(keyword);
      print(matchingWords);
      var res = await http.post(uri,
          body: json.encode(data),
          headers: {"Content-Type": "application/json"});
      // searchResult = List<BooksByCategory>.from(
      //     res.body.map((i) => BooksByCategory.fromJson(i)));
      searchResult = booksByCategoryFromJson(res.body);
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
      if(tmp == 0){
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
      if(tmp == 0){
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
    } else {
      history = [];
    }
  }

  void clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    history = [];
    prefs.setStringList("history", history);
  }

  void deleteSearchHistory(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    history.removeAt(index);
    prefs.setStringList("history", history);
  }
}
