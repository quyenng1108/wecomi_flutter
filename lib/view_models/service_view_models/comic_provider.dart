import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wecomi_flutter/models/comic.dart';

class ComicProvider with ChangeNotifier{
  List<Comic>? comic;
  List<Comic>? recommendedComic;
  bool isLoading = true;
  notifyListeners();
  String url = "http://117.103.207.22:8082/book/getMainPage";
  Future<void> getComicBySex(int sex) async{
  isLoading = true;
  Response res = await Dio().get(url, queryParameters: {
    "sex": sex
  });
  comic = List<Comic>.from(res.data.map((i) => Comic.fromJson(i)));
  print(comic);
  recommendedComic = comic!.where((i) => i.groupId == "1111111111").toList();
  print(isLoading);
  isLoading = false;
  print(isLoading);
  notifyListeners();
  }
}