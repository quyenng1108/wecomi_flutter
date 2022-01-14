import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/models/book_by_category.dart';
import 'package:wecomi_flutter/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:wecomi_flutter/models/comics.dart';

class GenreProvider with ChangeNotifier {
  Category category = Category();
  // List<BooksByCategory> booksByCategory = [];
  bool isLoading = true;
  bool isFetchingComicList = true;
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

  showComicProgress() {
    if (isFetchingComicList) {
      return;
    }
    isFetchingComicList = true;
    notifyListeners();
  }

  dismissComicProgress() {
    if (!isFetchingComicList) {
      return;
    }
    isFetchingComicList = false;
    notifyListeners();
  }

  Future<Category> getCategory() async {
    // category.clear();
    // subCategory.clear();
    String url = "${apiUrl}v1/public/tags/";
    showProgress();
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final response = Utf8Decoder().convert(res.bodyBytes);
      category = categoryFromJson(response);
      notifyListeners();
    }
    dismissProgress();
    return category;
  }

  Future<ComicByCategory> getComicByCategory(int id) async {
    dynamic parameter = {"type_book": category};
    ComicByCategory comic = ComicByCategory();
    String url = "${apiUrl}v1/public/tags/$id/book/";
    showComicProgress();
    Uri uri = Uri.parse(url);
    // dynamic res = await http.get(url,
    //     queryParameters: {"type_book": category},
    //     options: Options(headers: {"Content-Type": "application/json"}));
    dynamic res = await http.get(
      uri,
    );
    if (res.statusCode == 200) {
      String response = Utf8Decoder().convert(res.bodyBytes);
      comic = comicByCategoryFromJson(response);
      print(comic.results);
      notifyListeners();
    } else {
      comic = ComicByCategory();
    }
    dismissComicProgress();
    return comic;
  }
}
