import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/models/comics.dart';
import 'package:wecomi_flutter/models/read_history.dart';
import 'package:wecomi_flutter/view_models/service_view_models/getchapter_byBookuuid_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/read_history_provider.dart';
import 'package:wecomi_flutter/views/chapter_detail/chapter_detail_screen.dart';
import 'package:wecomi_flutter/views/test.dart';

class TabChapter extends StatefulWidget {
  int bookID;
  final ComicDetail? detail;
  TabChapter({Key? key, required this.bookID, required this.detail})
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
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  var buttonText = 'Mới nhất';
  bool isReverse = false;
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
                            isReverse ? isReverse = false : isReverse = true;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        child: Text(
                          isReverse ? "Cũ nhất" : "Mới nhất",
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
          return chapterByBook.isLoading
              ? Center(
                  child: LinearProgressIndicator(
                    color: majorPink
                  ),
                )
              : chapterByBook.chapterByBookId.chapter!.length == 0
                  ? Center(
                      child: Column(
                      children: [
                        Text("Truyện hiện tại vẫn chưa có chapter",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        Text("Hiện tại truyện vẫn chưa ra mắt chapter nào",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                        Text("Vui lòng chọn truyện khác",
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 16 * ratioW),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount:
                                chapterByBook.chapterByBookId.chapter!.length,
                            itemBuilder: (context, index) {
                              return isReverse
                                  ? BuildChapterList(
                                      ratioH: ratioH,
                                      ratioW: ratioW,
                                      chapterName: chapterByBook
                                          .chapterByBookId
                                          .chapter![chapterByBook
                                                  .chapterByBookId
                                                  .chapter!
                                                  .length -
                                              index -
                                              1]
                                          .title!,
                                      adultLimit: chapterByBook
                                              .chapterByBookId
                                              .chapter![chapterByBook
                                                      .chapterByBookId
                                                      .chapter!
                                                      .length -
                                                  index -
                                                  1]
                                              .number ??
                                          14,
                                      commentNo: chapterByBook
                                          .chapterByBookId
                                          .chapter![chapterByBook
                                                  .chapterByBookId
                                                  .chapter!
                                                  .length -
                                              index -
                                              1]
                                          .likeCount!,
                                      likeNo: chapterByBook
                                          .chapterByBookId
                                          .chapter![chapterByBook
                                                  .chapterByBookId
                                                  .chapter!
                                                  .length -
                                              index -
                                              1]
                                          .likeCount!,
                                      publishDate: chapterByBook
                                          .chapterByBookId
                                          .chapter![chapterByBook
                                                  .chapterByBookId
                                                  .chapter!
                                                  .length -
                                              index -
                                              1]
                                          .dateModified!,
                                      press: () {
                                        var bookDetail = json
                                            .encode(widget.detail!.toJson());
                                        var history = ReadHistory(
                                            chapterNum: index + 1,
                                            bookId: widget.detail!.id,
                                            thumbnail: widget.detail!.thumbnail,
                                            bookName: widget.detail!.title,
                                            detail: bookDetail);
                                        context
                                            .read<ReadHistoryProvider>()
                                            .saveReadHistory(history);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChapterDetailScreen(
                                                      readHistory: history,
                                                        bookDetailList:
                                                            chapterByBook
                                                                .chapterByBookId
                                                                .chapter!,
                                                        chapterIndex: chapterByBook
                                                                .chapterByBookId
                                                                .chapter!
                                                                .length -
                                                            index -
                                                            1)));
                                      },
                                    )
                                  : BuildChapterList(
                                      ratioH: ratioH,
                                      ratioW: ratioW,
                                      chapterName: chapterByBook.chapterByBookId
                                          .chapter![index].title!,
                                      adultLimit: chapterByBook.chapterByBookId
                                              .chapter![index].number ??
                                          12,
                                      commentNo: chapterByBook.chapterByBookId
                                          .chapter![index].likeCount!
                                          .toInt(),
                                      likeNo: chapterByBook.chapterByBookId
                                          .chapter![index].likeCount!
                                          .toInt(),
                                      publishDate: chapterByBook.chapterByBookId
                                          .chapter![index].dateModified!,
                                      press: () {
                                        var bookDetail = json
                                            .encode(widget.detail!.toJson());
                                        var history = ReadHistory(
                                            chapterNum: chapterByBook
                                                    .chapterByBookId
                                                    .chapter!
                                                    .length -
                                                index,
                                            bookId: widget.detail!.id,
                                            thumbnail: widget.detail!.thumbnail,
                                            bookName: widget.detail!.title,
                                            detail: bookDetail);
                                        context
                                            .read<ReadHistoryProvider>()
                                            .saveReadHistory(history);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChapterDetailScreen(
                                                      readHistory: history,
                                                        bookDetailList:
                                                            chapterByBook
                                                                .chapterByBookId
                                                                .chapter!,
                                                        chapterIndex: index)));
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
                  child: 
                      Text(
                        chapterName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
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
