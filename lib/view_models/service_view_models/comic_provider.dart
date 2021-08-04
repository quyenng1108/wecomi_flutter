import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wecomi_flutter/models/comic.dart';

class ComicProvider with ChangeNotifier{
  List<Comic>? comic;
  List<Comic>? recommendedComic;
  List<Comic>? hotComic;
  List<Comic>? likedComic;
  bool isLoading = true;
  notifyListeners();
  String url = "http://117.103.207.22:8082/book/getMainPage";
  Future<void> getComicBySex(int sex) async{
  isLoading = true;
  print(isLoading);
  Response res = await Dio().get(url, queryParameters: {
    "sex": sex
  });
  comic = List<Comic>.from(res.data.map((i) => Comic.fromJson(i)));
  print(comic);
  recommendedComic = comic!.where((i) => i.groupId == "1111111111").toList();
  hotComic = comic!.where((i) => i.groupId == "2222222222").toList();
  likedComic = comic!.where((i) => i.groupId == "3333333333").toList();
  print(hotComic?.length);
  isLoading = false;
  print(isLoading);
  notifyListeners();
  }
}