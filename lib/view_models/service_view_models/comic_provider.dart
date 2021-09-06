import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wecomi_flutter/models/book_by_category.dart';
import 'package:wecomi_flutter/models/category_model.dart';
import 'package:wecomi_flutter/models/comic.dart';

class ComicProvider with ChangeNotifier {
  List<Comic> comic = [];
  List<Comic>? recommendedComic = [];
  List<Comic>? hotComic = [];
  List<Comic>? likedComic = [];
  List<Category> category = [];
  List<Category> subCategory = [];
  List<BooksByCategory> booksByCategory = [];
  bool isLoading = true;
  List categoryList = [];
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

  Future<void> getComicBySex(int sex) async {
    // sex = 1 => Male, sex = 2 => Female
    String url = "http://117.103.207.22:8082/book/getMainPage";
    showProgress();
    Response res = await Dio().get(url,
        queryParameters: {"sex": sex},
        options: Options(headers: {"Content-Type": "application/json"}));
    if (res.statusCode == 200) {
      comic = (res.data as List).map((x) => Comic.fromJson(x)).toList();
      recommendedComic = comic.where((i) => i.groupId == "1111111111").toList();
      hotComic = comic.where((i) => i.groupId == "2222222222").toList();
      likedComic = comic.where((i) => i.groupId == "3333333333").toList();
      notifyListeners();
    } else {
      throw Exception("failed");
    }
    dismissProgress();
  }

  //   Future<void> getCategory(int id) async {
  //   category.clear();
  //   subCategory.clear();
  //   String url = "http://117.103.207.22:8082/book/bookCategoryHierarchy";
  //   showProgress();
  //   Response res = await Dio().get(url, queryParameters: {
  //     "categoryId" : id
  //   });
  //   // print(res);
  //   category = List<Category>.from(res.data.map((i) => Category.fromJson(i)));
  //   subCategory = category.where((i) => i.level == 2).toList();
  //   notifyListeners();
  //   // print(subCategory);
  //   dismissProgress();
  // }
  // Future<void> getBooksByCategory(int id) async{
  //   String url = "http://117.103.207.22:8082/book/getBookByCate";
  // showProgress();
  // Response res = await Dio().get(url, queryParameters: {
  //   "categoryId" : id
  // });
  // booksByCategory = List<BooksByCategory>.from(res.data.map((i) => BooksByCategory.fromJson(i)));
  // for(int i = 0; i < booksByCategory.length; i++){
  //     categoryList = booksByCategory[i].categoryList!.split(";");
  // }
  // notifyListeners();
  // dismissProgress();
  // }

}
