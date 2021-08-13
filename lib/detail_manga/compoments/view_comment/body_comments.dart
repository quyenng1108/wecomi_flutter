import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/theme.dart';

import 'screen_detail_comment/comment.dart';

class Comments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Bình luận nổi bật", style: kLargeNormalBodyTextStyle),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Comment(),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Xem tất cả",
                      style: TextStyle(
                        color: ThemeConfig.bgTextComment,
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: ThemeConfig.colorText,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
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
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
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
          ),
        ],
      ),
    );
  }
}
