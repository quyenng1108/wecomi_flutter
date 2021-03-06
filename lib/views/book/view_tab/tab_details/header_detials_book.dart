import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/models/book_detail.dart';
import 'package:wecomi_flutter/models/comics.dart';
import 'package:wecomi_flutter/view_models/service_view_models/book_provider.dart';
import 'package:wecomi_flutter/views/book/screen/screen_recomment_gift.dart';
import 'package:wecomi_flutter/views/book/screen/screen_top_rank.dart';

class Content extends StatefulWidget {
  Content({@required this.comicDetail});
  final ComicDetail? comicDetail;
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
        // Consumer<BookProvider>(
        //   builder: (context, bookProvider, child) {
        //     return bookProvider.book.length == 0 && !bookProvider.isLoading
        //         ? LinearProgressIndicator()
        //         : bookProvider.isLoading
        //             ? Shimmer.fromColors(
        //                 child: Container(
        //                   height: 71 * ratioH,
        //                   width: 343 * ratioW,
        //                 ),
        //                 baseColor: Colors.grey[300]!,
        //                 highlightColor: Colors.grey[100]!)
        //             : 
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {},
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            widget.comicDetail!.star.toString() == "null" ? "5" : widget.comicDetail!.star.toString(),
                                            style: TextStyle(
                                                color: ThemeConfig.colorText),
                                          ),
                                          Image.asset("assets/icons/Star.png")
                                        ],
                                      ),
                                      Text(
                                        "????nh Gi??",
                                        style: textComment,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Counter(
                              action: widget.comicDetail!.likeCount.toString(),
                              title: "L?????t th??ch",
                            ),
                            Counter(
                              action: widget.comicDetail!.countComment.toString(),
                              title: "B??nh lu???n",
                            ),
                            Counter(
                              action:
                                  widget.comicDetail!.likeCount.toString(),
                              title: "????? tu???i",
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
                              widget.comicDetail!.description!,
                              expandText: '\nshow more',
                              collapseText: 'show less',
                              maxLines: 3,
                              linkColor: ThemeConfig.colorText,
                              collapseOnTextTap: true,
                              animationDuration: Duration(milliseconds: 1200),
                            ),
                          ],
                        ),
                      ),
        
        
     Container(
                        height: 55 * ratioH,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ListCategory(
                              bookCategory: widget.comicDetail!.author!,
                              ratioW: ratioW,
                              ratioH: ratioH,
                              backgroundColor: majorPink,
                              textColor: Colors.white,
                            ),
                            // for (int i = 0;
                            //     i < bookProvider.book[0].category!.length;
                            //     i++)
                            //   ListCategory(
                            //       ratioW: ratioW,
                            //       ratioH: ratioH,
                            //       bookCategory: bookProvider
                            //           .book[0].category![i].categoryName
                            //           .toString(),
                            //       backgroundColor: Color(0xffF4F6F9),
                            //       textColor: ThemeConfig.bgTextComment),
                          ],
                        ),
                      ),
        const Divider(),
        // Container(
        //   padding: EdgeInsets.only(top: 10 * ratioH),
        //   child: Row(
        //     children: <Widget>[
        //       CircleAvatar(
        //         backgroundImage: AssetImage("assets/images/bxhno1.png"),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 15.0),
        //         child: Text(
        //           "Nh???ng k??? m???ng mer",
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 15,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 10.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: <Widget>[
        //       BuildContent(
        //         image: "assets/icons/gift.png",
        //         title: '????? xu???t',
        //         onClicked: showSheet,
        //       ),
        //       BuildContent(
        //         image: "assets/icons/award.png",
        //         title: 'Qu?? t???ng',
        //         onClicked: showSheet,
        //       ),
        //       BuildContent(
        //         image: "assets/icons/cup.png",
        //         title: 'BXH Fan',
        //         onClicked: () => Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => TopRank(comicDetail: widget.comicDetail,),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const Divider(),
      ],
    );
  }

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

class ListCategory extends StatelessWidget {
  final String bookCategory;
  final Color backgroundColor;
  final Color textColor;
  const ListCategory({
    Key? key,
    required this.ratioW,
    required this.ratioH,
    required this.bookCategory,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  final double ratioW;
  final double ratioH;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 8 * ratioW),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 10 * ratioW, vertical: 3.5 * ratioH),
            height: 35 * ratioH,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: backgroundColor,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(bookCategory,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor)),
            ),
          )
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final String action;
  final String title;
  const Counter({Key? key, required this.action, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                action,
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

class BuildContent extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onClicked;
  const BuildContent({
    Key? key,
    required this.title,
    required this.image,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Container(
      child: Container(
        height: 68 * ratioH,
        width: 109 * ratioW,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xffF05A77)),
          color: Colors.white,
        ),
        child: TextButton(
          onPressed: onClicked,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 24 * ratioH,
                width: 24 * ratioW,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8 * ratioH),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: ThemeConfig.colorText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
