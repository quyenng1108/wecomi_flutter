import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/components/chat_input.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'body_comment.dart';

class ScreenComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: BodyComment(),
      ),
      bottomNavigationBar: Container(child: ChatInputField()),
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
