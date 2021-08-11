import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/models/book_by_category.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  List<BooksByCategory> searchResult = [];
  bool isLoading = true;
  String _key = "";
  String get key => _key;
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

  void splitString(String string) {
    matchingWords = string.split(' ');
    notifyListeners();
  }

  void clearSearch() {
    _key = "";
    notifyListeners();
  }

  // Future<List<BooksByCategory>> search(String keyword, int id) async {
  //   Map data = {"searchWord": keyword, "categoryId": id};
  //   String url = "http://117.103.207.22:8082/book/bookSearchPageKeyword";
  //   matchingWords = [];
  //   _key = keyword;
  //   if (keyword != "") {
  //     showProgress();
  //     splitString(keyword);
  //     print(matchingWords);
  //     Response res = await Dio().post(url,
  //         data: data,
  //         options: Options(headers: {"Content-Type": "application/json"}));

  //     if(res.data is List){
  //       print("list");
  //     }else if(res.data is String){
  //       print("string");
  //     }else {
  //       print("chiu");
  //     }
  //     searchResult = List<BooksByCategory>.from(
  //         res.data.map((i) => BooksByCategory.fromJson(i)));
  //     // searchResult = booksByCategoryFromJson(json.decode(res.data));
  //     print(searchResult);
  //     notifyListeners();
  //     dismissProgress();
  //   } else {
  //     print("Error");
  //     notifyListeners();
  //   }
  //   return searchResult;
  // }
  Future<List<BooksByCategory>> search(String keyword, int id) async {
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

      if(res.body is List){
        print("list");
      }else if(res.body is String){
        print("string");
      }else {
        print("chiu");
      }
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
    return searchResult;
  }
}
