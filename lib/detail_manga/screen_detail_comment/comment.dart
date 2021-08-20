import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/detail_manga/screen_detail_comment/compoments/body_details_comment.dart';
import 'package:wecomi_flutter/detail_manga/screen_detail_comment/compoments/chat_input.dart';

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: BodyComment(),
      ),
      bottomNavigationBar: ChatInputField(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ThemeConfig.bgColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Text(
              "Tất cả bình luận",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
