import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/view_models/service_view_models/getchapter_byBookuuid_provider.dart';

class TabChapter extends StatefulWidget {
  String bookID;
  TabChapter({Key? key, required this.bookID})
      : super(
          key: key,
        );

  @override
  _TabChapterState createState() => _TabChapterState();
}

class _TabChapterState extends State<TabChapter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ChapterByBookIDProvider>(context, listen: false)
          .getChapterByBookId(widget.bookID);
    });
  }

  var buttonText = 'Mới nhất';

  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16 * ratioW),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * ratioW),
                        child: Image.asset("assets/icons/frame.png")),
                    Container(
                      width: 90 * ratioW,
                      child: TextButton(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Consumer<ChapterByBookIDProvider>(
            builder: (context, chapterByBook, child) {
          return chapterByBook.chapterByBookId.length == 0 &&
                  !chapterByBook.isLoading
              ? Center(
                  child: Column(
                  children: [
                    Text("Vào làm gì ???",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    Text("Có chap nào đâu",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    Text("Tìm truyện khác đi :v",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w500))
                  ],
                ))
              : chapterByBook.isLoading
                  ? Shimmer.fromColors(
                      child: Center(),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!)
                  : Expanded(
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16 * ratioW),
                      child: ListView.builder(
                        itemCount: chapterByBook.chapterByBookId.length,
                        itemBuilder: (context, index) {
                          return BuildChapterList(
                            ratioH: ratioH,
                            ratioW: ratioW,
                            chapterName: chapterByBook
                                .chapterByBookId[index].chapterName
                                .toString(),
                            adultLimit: chapterByBook
                                .chapterByBookId[index].adultLimit!
                                .toInt(),
                            commentNo: chapterByBook
                                .chapterByBookId[index].commentNo!
                                .toInt(),
                            likeNo: chapterByBook.chapterByBookId[index].likeNo!
                                .toInt(),
                            publishDate: chapterByBook
                                .chapterByBookId[index].publishDate!,
                            press: () {
                              print("object");
                            },
                          );
                        },
                      ),
                    ));
        })
      ],
    );
  }
}

class BuildChapterList extends StatelessWidget {
  const BuildChapterList({
    Key? key,
    required this.ratioH,
    required this.ratioW,
    required this.press,
    required this.chapterName,
    required this.adultLimit,
    required this.likeNo,
    required this.commentNo,
    required this.publishDate,
  }) : super(key: key);

  final double ratioH;
  final double ratioW;
  final VoidCallback press;
  final String chapterName;
  final int adultLimit;
  final int likeNo;
  final int commentNo;
  final DateTime publishDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5 * ratioH),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(
                        chapterName,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10 * ratioW),
                  child: Text("Tuổi " + adultLimit.toString() + "+",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10 * ratioW),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5 * ratioW),
                              child: Image.asset("assets/icons/heart_white.png",
                                  width: 13 * ratioW, height: 12 * ratioH),
                            ),
                            Text(
                              likeNo.toString(),
                              style: textComment,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 5 * ratioW),
                            child: Image.asset("assets/images/comment.png",
                                width: 13 * ratioW, height: 12 * ratioH),
                          ),
                          Text(
                            commentNo.toString(),
                            style: textComment,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10 * ratioW),
                  child: Text(DateFormat('yyyy/MM/dd').format(publishDate)),
                ),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
