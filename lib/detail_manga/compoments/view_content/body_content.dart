import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/detail_manga/compoments/view_content/screen/buildWidget.dart';
import 'package:wecomi_flutter/detail_manga/compoments/view_content/screen/view_recomment_gift.dart';
import 'package:wecomi_flutter/detail_manga/compoments/view_content/screen/view_topRank.dart';

class Content extends StatefulWidget {
  const Content({
    Key? key,
  }) : super(key: key);
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Column(
      children: <Widget>[
        Container(
          height: 71 * ratioH,
          width: 343 * ratioW,
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xffF05A77)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "4.8",
                              style: TextStyle(color: ThemeConfig.colorText),
                            ),
                            Image.asset("assets/images/Star.png")
                          ],
                        ),
                        Text(
                          "Đánh Giá",
                          style: textComment,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Counter(
                number: "8.2K",
                title: "Bình luận",
              ),
              Counter(
                number: "15.2K",
                title: "Lượt xem",
              ),
              Counter(
                number: "1.2K",
                title: "Theo dõi",
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0 * ratioH),
              ExpandableText(
                'Bị đồng nghiệp hãm hại ngay ngày sinh nhật thứ 22, Mei Fug trở thành một kẻ thất nghiệp không nhà không cửa. Trong lúc cô đang tuyệt vọng, một bàn tay đưa ra kéo cô về với hiện thực. Có lẽ yêu đương lúc này cũng không phải ý tồi. Lợi dụng anh ta để trả th....',
                expandText: '\nshow more',
                collapseText: '\nshow less',
                maxLines: 3,
                linkColor: ThemeConfig.colorText,
                collapseOnTextTap: true,
                animationDuration: Duration(milliseconds: 1200),
              ),
            ],
          ),
        ),
        Container(
          height: 50 * ratioH,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                child: MyListView(title_caption: "Manga"),
              );
            },
          ),
        ),
        const Divider(),
        Container(
          padding: EdgeInsets.only(top: 10 * ratioH),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/bg.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Những kẻ mộng mer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              BuildContent(
                image_captions: "assets/images/gift.png",
                title_captions: 'Đề xuất',
                onClicked: showSheet,
              ),
              BuildContent(
                image_captions: "assets/images/award.png",
                title_captions: 'Quà tặng',
                onClicked: showSheet,
              ),
              BuildContent(
                image_captions: "assets/images/cup.png",
                title_captions: 'BXH Fan',
                onClicked: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => topRank(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  // Widget buildSheet() => RecommentGift();
  Future showSheet() => showSlidingBottomSheet(
        context,
        builder: (context) => SlidingSheetDialog(
          cornerRadius: 20,
          snapSpec: SnapSpec(
            snappings: [0.4, 0.7],
          ),
          builder: buildSheet,
        ),
      );
  Widget buildSheet(context, state) => Material(
        color: Colors.white,
        child: RecommentGift(),
      );
  // DefaultTabController(length: 2, child: Scaffold());

}

class MyListView extends StatelessWidget {
  final String title_caption;
  final Color? color;
  const MyListView({Key? key, required this.title_caption, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0.0,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  // decoration: BoxDecoration(color: Colors.black12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffF05A77)),
                    color: Colors.white,
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title_caption,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeConfig.colorText,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final String title;
  final String number;
  const Counter({
    Key? key,
    required this.title,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Column(
        children: [
          Row(
            children: [
              Text(
                number,
                style: TextStyle(color: ThemeConfig.colorText),
              ),
            ],
          ),
          Text(
            title,
            style: textComment,
          ),
        ],
      ),
    );
  }
}