import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

import 'package:wecomi_flutter/models/image.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';

class ChangeInformationProvider extends ChangeNotifier {
  bool isLoading = false;
  String? imgUrl;
  bool isEditing = false;
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

  void toggleEditing() {
    isEditing = !isEditing;
    notifyListeners();
  }

  Future<void> getAvatarUrl(String file, BuildContext context) async {
    String url = "${apiUrl}v1/image/";
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": AppSession().token!
    };
    showProgress();
    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath("image", file));
    var res = await request.send();
    res.stream.transform(utf8.decoder).listen((value) {
      print(value);
      ImagePost img = imagePostFromJson(value);
      imgUrl = img.image!;
      print("hehe $imgUrl");
      Provider.of<LoginProvider>(context, listen: false).setAvatar(imgUrl!);
    });
    
    dismissProgress();
  }
}
