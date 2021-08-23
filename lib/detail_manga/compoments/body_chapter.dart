import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/detail_manga/models/Chapter.dart';

import 'cart_chapter.dart';

class BodyChapter extends StatefulWidget {
  @override
  _BodyChapterState createState() => _BodyChapterState();
}

class _BodyChapterState extends State<BodyChapter> {
  late final Chapter chapter;
  var buttonText = 'Mới nhất';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "Cập nhật đến",
                  style: kMediumBodyTextStyle,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Image.asset("assets/images/frame.png"),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          buttonText = 'Cũ nhất';
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: Text(
                        buttonText,
                        style: text,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            // itemBuilder: (context, index) => Text("test"),
            itemCount: chapterData.length,
            itemBuilder: (context, index) => CardChapter(
              chapter: chapterData[index],
              press: () {},
            ),
          ),
        ),
      ],
    );
  }
}
