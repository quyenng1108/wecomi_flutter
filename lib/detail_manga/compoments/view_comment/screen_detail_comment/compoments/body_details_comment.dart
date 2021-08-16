import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/theme.dart';

class BodyComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            children: [
              Column(
                children: [
                  buildComments(
                    avatar_image: "assets/images/avt.png",
                    name_comment: "Trúc Lâm",
                    chapter: "Chap 13",
                    comments:
                        "Nghỉ dịch ở nhà chán quá, mong truyện ra lẹ lẹ lên cho có cái để ngồi đọc.",
                    time_comment: "12 giờ trước",
                    lv_comment: "Lv.8",
                    heart_like: "12",
                    int_comment: "11",
                  ),
                ],
              ),
              buildComments(
                avatar_image: "assets/images/avt.png",
                name_comment: "Vũ Thị Linh",
                chapter: "Chap 5",
                comments:
                    "Đợi từng giờ từng phút để hóng chap mới. Yêu anh hoàng tử <3 <3 <3",
                time_comment: "2 giờ trước",
                lv_comment: "Lv.7",
                heart_like: "10",
                int_comment: "6",
              ),
              buildComments(
                avatar_image: "assets/images/avt.png",
                name_comment: "Phúc Trần",
                chapter: "Chap 20",
                comments: "Đợi từng giờ từng phút để hóng chap mới.",
                time_comment: "1 giờ trước",
                lv_comment: "Lv.10",
                heart_like: "20",
                int_comment: "10",
              ),
            ],
          ),
        ),
        const Divider(),
        Container(
          height: 42 * ratioH,
          width: 343 * ratioW,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ThemeConfig.bgColor),
              color: Colors.white,
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Tải thêm bình luận",
                style: TextStyle(
                    color: ThemeConfig.bgColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class buildComments extends StatelessWidget {
  final String avatar_image;
  final String name_comment;
  final String lv_comment;
  final String chapter;
  final String comments;
  final String time_comment;
  final String heart_like;
  final String int_comment;
  const buildComments({
    Key? key,
    required this.avatar_image,
    required this.name_comment,
    required this.lv_comment,
    required this.chapter,
    required this.comments,
    required this.time_comment,
    required this.heart_like,
    required this.int_comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(avatar_image),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: ThemeConfig.bgComment),
                        color: ThemeConfig.bgComment,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      name_comment,
                                      style: kMediumBodyTextStyle,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 1.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: ThemeConfig.colorText),
                                        ),
                                        child: Text(
                                          lv_comment,
                                          style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: ThemeConfig.colorText),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                chapter,
                                style: textComment,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ExpandableText(
                              comments,
                              expandText: 'Xem thêm',
                              maxLines: 2,
                              linkColor: ThemeConfig.bgTextComment,
                              collapseOnTextTap: true,
                              animationDuration: Duration(milliseconds: 1200),
                              style: textComment1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      time_comment,
                                      style: timeComment,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/heart.png",
                                        ),
                                        Text(
                                          heart_like,
                                          style: textComment,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/comment.png",
                                        ),
                                        Text(
                                          int_comment,
                                          style: textComment,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    buildCommentChild(
                      avatar_image: avatar_image,
                      name_comment: name_comment,
                      lv_comment: lv_comment,
                      comments: comments,
                      time_comment: time_comment,
                      heart_like: heart_like,
                    ),
                    buildCommentChild(
                        avatar_image: avatar_image,
                        name_comment: name_comment,
                        lv_comment: lv_comment,
                        comments: comments,
                        time_comment: time_comment,
                        heart_like: heart_like),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class buildCommentChild extends StatelessWidget {
  final String avatar_image;
  final String name_comment;
  final String lv_comment;
  final String comments;
  final String time_comment;
  final String heart_like;

  const buildCommentChild({
    Key? key,
    required this.avatar_image,
    required this.name_comment,
    required this.lv_comment,
    required this.comments,
    required this.time_comment,
    required this.heart_like,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 60),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(avatar_image),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: ThemeConfig.bgComment),
                color: ThemeConfig.bgComment,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: [
                            Text(
                              name_comment,
                              style: kMediumBodyTextStyle,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 1.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: ThemeConfig.colorText),
                                ),
                                child: Text(
                                  "Lv.9",
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      color: ThemeConfig.colorText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ExpandableText(
                      "Nghỉ dịch ở nhà chán quá, mong truyện ra lẹ lẹ lên cho có cái để ngồi đọc.",
                      expandText: 'Xem thêm',
                      maxLines: 2,
                      linkColor: ThemeConfig.bgTextComment,
                      collapseOnTextTap: true,
                      animationDuration: Duration(milliseconds: 1200),
                      style: textComment1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: [
                            Text(
                              time_comment,
                              style: timeComment,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/heart.png",
                                ),
                                Text(
                                  "5",
                                  style: textComment,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
