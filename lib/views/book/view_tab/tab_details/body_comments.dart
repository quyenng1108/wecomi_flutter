import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/views/book/screen/screen_comment.dart';

class Comments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
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
                    builder: (context) => ScreenComment(),
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
          padding: EdgeInsets.only(bottom: 15 * ratioH),
          child: Column(
            children: [
              BuildComments(
                avatar: "assets/images/avt.png",
                nameComment: "Trúc Lâm",
                chapter: "Chap 13",
                comments:
                    "Nghỉ dịch ở nhà chán quá, mong truyện ra lẹ lẹ lên cho có cái để ngồi đọc.",
                timeComment: "12 giờ trước",
                levelAcccount: "Lv.8",
                heartLike: "12",
                numberComment: "11",
              ),
              BuildComments(
                avatar: "assets/images/avt.png",
                nameComment: "Vũ Thị Linh",
                chapter: "Chap 5",
                comments:
                    "Đợi từng giờ từng phút để hóng chap mới. Yêu anh hoàng tử <3 <3 <3",
                timeComment: "2 giờ trước",
                levelAcccount: "7",
                heartLike: "10",
                numberComment: "6",
              ),
              BuildComments(
                avatar: "assets/images/avt.png",
                nameComment: "Phúc Trần",
                chapter: "Chap 20",
                comments: "Đợi từng giờ từng phút để hóng chap mới.",
                timeComment: "1 giờ trước",
                levelAcccount: "Lv.10",
                heartLike: "20",
                numberComment: "10",
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class BuildComments extends StatelessWidget {
  final String avatar;
  final String nameComment;
  final String levelAcccount;
  final String chapter;
  final String comments;
  final String timeComment;
  final String heartLike;
  final String numberComment;
  const BuildComments({
    Key? key,
    required this.avatar,
    required this.nameComment,
    required this.levelAcccount,
    required this.chapter,
    required this.comments,
    required this.timeComment,
    required this.heartLike,
    required this.numberComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(avatar),
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
                              nameComment,
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
                                  levelAcccount,
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
                              timeComment,
                              style: realTimeComment,
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
                                  "assets/icons/heart.png",
                                ),
                                Text(
                                  heartLike,
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
                                  numberComment,
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
