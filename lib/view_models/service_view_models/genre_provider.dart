import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/models/book_by_category.dart';
import 'package:wecomi_flutter/models/category_model.dart';

class GenreProvider with ChangeNotifier{
  List<Category> category = [];
  List<Category> subCategory = [];
  List<BooksByCategory> booksByCategory = [];
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
    Future<List<Category>> getCategory(int id) async {
    // category.clear();
    // subCategory.clear();
    String url = "http://117.103.207.22:8082/book/bookCategoryHierarchy";
    showProgress();
    Response res = await Dio().get(
      url, queryParameters: {
      "categoryId" : id,
    },
    options: Options(
      headers: {
        "Content-Type" : "application/json"
      }
    ));
    // print(res);
    category = List<Category>.from(res.data.map((i) => Category.fromJson(i)));
    subCategory = category.where((i) => i.level == 2).toList();
    notifyListeners();
    // print(subCategory);
    dismissProgress();
    return category;
  }
  Future<List<BooksByCategory>> getBooksByCategory(int parentCategoryId, int categoryId) async{
    String url = "http://117.103.207.22:8082/book/getBookByCate";
  showProgress();
  Response res = await Dio().get(url, queryParameters: {
    "parentCategoryId" : parentCategoryId,
    "categoryId" : categoryId
  },
   options: Options(
      headers: {
        "Content-Type" : "application/json"
      }));
  booksByCategory = List<BooksByCategory>.from(res.data.map((i) => BooksByCategory.fromJson(i)));
  notifyListeners();
  dismissProgress();
  return booksByCategory;
  }
}