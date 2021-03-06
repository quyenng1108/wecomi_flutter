import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/category_bubble.dart';
import 'package:wecomi_flutter/components/list_item_book.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/view_models/service_view_models/search_provider.dart';
import 'package:wecomi_flutter/views/book/book_screen.dart';
import 'package:wecomi_flutter/views/see_all_screen/see_all_screen.dart';

TextEditingController controller = TextEditingController();

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _tabController = TabController(length: 2, vsync: this);
      SearchProvider searchProvider =
          Provider.of<SearchProvider>(context, listen: false);
      searchProvider.loadHistory();
      searchProvider.getHotKeyword();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  TabController? _tabController;
  int _index = 0;
  String text = "";
  String? hintText;
  @override
  Widget build(BuildContext context) {
    print(Provider.of<SearchProvider>(context, listen: false).history);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    // final style = widget.text.isEmpty ? styleHint : styleActive;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) => Column(children: [
                    SizedBox(
                      height: height * 0.0098,
                    ),
                    Container(
                        height: 40,
                        margin: standardSpacing,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.arrow_back_ios,
                                  size: 24, color: darkGrey),
                              onTap: () {
                                Navigator.pop(context);
                                controller.clear();
                                searchProvider.search("");
                                searchProvider.clearSearch();
                                // widget.onChanged('');
                                // FocusScope.of(context)
                                //     .requestFocus(FocusNode());
                              },
                              // CustomBackButton(color: Colors.grey),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Container(
                                // alignment: Alignment.center,
                                height: 44,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(48),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff08252B).withOpacity(.1),
                                        blurRadius: 3,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]),
                                // padding: const EdgeInsets.only(left: 8),
                                child: CupertinoTextField(
                                  placeholder:
                                      " T??n t??c ph???m, t??c gi???, th??? lo???i...",
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  maxLines: 1,
                                  autofocus: true,
                                  cursorColor: buttonColor,
                                  textAlignVertical: TextAlignVertical.center,
                                  onSubmitted: (String value) {
                                    searchProvider.search(value);
                                    searchProvider.saveSearchHistory(value);
                                    FocusScope.of(context).unfocus();
                                  },
                                  textInputAction: TextInputAction.search,
                                  autocorrect: false,
                                  controller: controller,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(48),
                                  ),
                                  suffix: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Image.asset(
                                      "assets/icons/Search.png",
                                      height: 24,
                                      // color: Colors.grey,
                                    ),
                                  ),
                                  // decoration: InputDecoration(
                                  //   icon: Image.asset(
                                  //     "assets/icons/Search.png",
                                  //     height: 24,
                                  //     color: Colors.grey,
                                  //   ),
                                  //   // prefixIcon: Image.asset("assets/icons/Search.png", height: 24,),
                                  //   suffixIcon: controller.text.isNotEmpty ||
                                  //           controller.text != ''
                                  //       ? GestureDetector(
                                  //           child: Icon(Icons.close,
                                  //               color: darkGrey, size: 24),
                                  //           onTap: () {
                                  //             controller.clear();
                                  //             searchProvider.search("", 1);
                                  //             searchProvider.clearSearch();
                                  //             // widget.onChanged('');
                                  //             FocusScope.of(context)
                                  //                 .requestFocus(FocusNode());
                                  //           },
                                  //         )
                                  //       : null,
                                  //   hintText:
                                  //       " T??n t??c ph???m, t??c gi???, th??? lo???i...",
                                  //   hintStyle:
                                  //       regularExtraLightBlackBodyTextStyle
                                  //           .copyWith(height: 1.5),
                                  //   border: InputBorder.none,
                                  //   // contentPadding: EdgeInsets.only(bottom: 15, top: 12)
                                  // ),
                                  // textAlign: TextAlign.left,
                                  style: regularBodyTextStyle,
                                  onChanged: (String value) {
                                    if (value == '') {
                                      searchProvider.setKeyWord(value);
                                    }
                                    // setState(() {
                                    //   text = controller.text;
                                    // });
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                    searchProvider.key == ""
                        ? Expanded(
                            child: Padding(
                            padding: standardSpacing,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.0246,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        // onTap: () => Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             SeeAllScreen(
                                        //                 screenName:
                                        //                     "Truy???n hot",
                                        //                 parentCategoryId: 1,
                                        //                 id: 9998))),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.asset(
                                            "assets/images/Hot.png",
                                            // height: height * 0.1428,
                                            width: width * 0.4453,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        // onTap: () => Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             SeeAllScreen(
                                        //                 screenName:
                                        //                     "C?? th??? b???n th??ch",
                                        //                 parentCategoryId: 1,
                                        //                 id: 9999)
                                        //                 )
                                        // ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.asset(
                                              "assets/images/MaybeYouLike.png",
                                              // height: height * 0.1428,
                                              width: width * 0.4453),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0295,
                                  ),
                                  Text("Xu h?????ng t??m ki???m",
                                      style: largeTitleTextStyle),
                                  SizedBox(
                                    height: height * 0.0147,
                                  ),
                                  searchProvider.hotKeyword == null
                                      ? Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            for (int i = 0; i < 6; i++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Shimmer.fromColors(
                                                    child: Container(
                                                      height: 34,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(
                                                                      0xff08252B)
                                                                  .withOpacity(
                                                                      .1),
                                                              spreadRadius: 0,
                                                              blurRadius: 3,
                                                              offset: Offset(0,
                                                                  1), // changes position of shadow
                                                            ),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                    ),
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!),
                                              )
                                          ],
                                        )
                                      : Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    searchProvider.hotKeyword!
                                                        .results!.length;
                                                i++)
                                              Material(
                                                type: MaterialType.transparency,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: width * 0.0213,
                                                      right: width * 0.0213),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CategoryBubble(
                                                        category: searchProvider
                                                            .hotKeyword!
                                                            .results![i]
                                                            .text,
                                                        onTap: () {
                                                          controller.text =
                                                              searchProvider
                                                                  .hotKeyword!
                                                                  .results![i]
                                                                  .text!;
                                                          searchProvider.search(
                                                            searchProvider
                                                                .hotKeyword!
                                                                .results![i]
                                                                .text!,
                                                          );
                                                          searchProvider
                                                              .saveSearchHistory(
                                                                  searchProvider
                                                                      .hotKeyword!
                                                                      .results![
                                                                          i]
                                                                      .text!);
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                        },
                                                        color: Colors.white,
                                                        style: regularBodyTextStyle
                                                            .copyWith(
                                                                color:
                                                                    lightBlack),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: height * 0.0295,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("L???ch s??? t??m ki???m",
                                          style: largeTitleTextStyle),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right: width * 0.0213),
                                          child: GestureDetector(
                                            onTap: () {
                                              searchProvider.clearHistory();
                                            },
                                            child: Image.asset(
                                              "assets/icons/Delete.png",
                                              height: 24,
                                            ),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0098,
                                  ),
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: searchProvider.history.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.0213),
                                            height: height * 0.0468,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      controller.text =
                                                          searchProvider
                                                              .history[index];
                                                      searchProvider.search(
                                                        searchProvider
                                                            .history[index],
                                                      );
                                                    },
                                                    child: Text(searchProvider
                                                        .history[index])),
                                                GestureDetector(
                                                  child: Image.asset(
                                                    "assets/icons/Close.png",
                                                    height: 24,
                                                  ),
                                                  onTap: () {
                                                    searchProvider
                                                        .deleteSearchHistory(
                                                            index);
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          )),
                                ],
                              ),
                            ),
                          ))
                        // : searchProvider.isLoading == true
                        //     ? Expanded(
                        //         child: Center(
                        //           child: CircularProgressIndicator(),
                        //         ),
                        //       )
                        : searchProvider.searchResult == null &&
                                !searchProvider.isLoading
                            ? Expanded(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/Nothing.png",
                                    width: width * 0.8053,
                                  ),
                                  SizedBox(
                                    height: height * 0.0296,
                                  ),
                                  Text(
                                      "Kh??ng t??m th???y truy???n ???ng v???i t??? kh??a v???a t??m",
                                      style: largeRegularBodyTextStyle)
                                ],
                              ))
                            : Expanded(
                                child: Column(
                                  children: [
                                    searchProvider.isLoading == true
                                        ? Expanded(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                  color: majorPink),
                                            ),
                                          )
                                        : Expanded(
                                            child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: ListView.builder(
                                                itemCount: searchProvider
                                                    .searchResult!
                                                    .results!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) => BookScreen(
                                                                  detail: searchProvider
                                                                          .searchResult!
                                                                          .results![
                                                                      index])));
                                                    },
                                                    child: SearchItems(
                                                      source:
                                                          "${apiUrlNoSlash}${searchProvider
                                                          .searchResult!
                                                          .results![index]
                                                          .thumbnail}",
                                                      title: searchProvider
                                                          .searchResult!
                                                          .results![index]
                                                          .title,
                                                      category: Text(
                                                          searchProvider
                                                              .searchResult!
                                                              .results![index]
                                                              .tag!,
                                                          style:
                                                              smallRegularLightBlackBodyTextStyle),
                                                      author: searchProvider
                                                          .searchResult!
                                                          .results![index]
                                                          .author,
                                                      rating: searchProvider
                                                                  .searchResult!
                                                                  .results![
                                                                      index]
                                                                  .star ==
                                                              null
                                                          ? "0"
                                                          : searchProvider
                                                              .searchResult!
                                                              .results![index]
                                                              .star
                                                              .toString(),
                                                      searchKeyword:
                                                          searchProvider
                                                              .matchingWords,
                                                      chapterNum:
                                                          Random().nextInt(10),
                                                    ),
                                                  );
                                                }),
                                          )),

                                    // Expanded(
                                    //   child: ListView.builder(
                                    //   padding: EdgeInsets.only(
                                    //       top: height * 0.0197,
                                    //       bottom: height * 0.0394,
                                    //       left: width * 0.0427,
                                    //       right: width * 0.0427),
                                    //   itemCount:
                                    //       searchProvider.searchResult.length,
                                    //   itemBuilder: (context, index) {
                                    //     var category;
                                    //     var secondCategory;
                                    //     var categoryList;
                                    //     if (Provider.of<SearchProvider>(
                                    //                 context)
                                    //             .isLoading ==
                                    //         false) {
                                    //       categoryList = searchProvider
                                    //           .searchResult[index]
                                    //           .categoryList!
                                    //           .split(";");
                                    //       if (categoryList.length > 1) {
                                    //         category = categoryList[0];
                                    //         secondCategory = categoryList[1];
                                    //       }
                                    //     }
                                    //     return SearchItems(
                                    //       searchKeyword:
                                    //           searchProvider.matchingWords,
                                    //       source: searchProvider
                                    //           .searchResult[index].imgUrl,
                                    //       title: searchProvider
                                    //           .searchResult[index].bookName,
                                    //       author: searchProvider
                                    //           .searchResult[index].authorNick,
                                    //       rating: searchProvider
                                    //           .searchResult[index].rating,
                                    //       chapterNum: searchProvider
                                    //           .searchResult[index]
                                    //           .numberOfChapter,
                                    //       category: categoryList.length > 1
                                    //           ? Text(
                                    //               "$category ??? $secondCategory",
                                    //               style:
                                    //                   smallRegularBodyTextStyle
                                    //                       .copyWith(
                                    //                           color:
                                    //                               lightBlack),
                                    //             )
                                    //           : Text(
                                    //               "${searchProvider.searchResult[index].categoryList}",
                                    //               style:
                                    //                   smallRegularBodyTextStyle
                                    //                       .copyWith(
                                    //                           color:
                                    //                               lightBlack)),
                                    //     );
                                    //   }),
                                    // )
                                  ],
                                ),
                              )
                  ])),
        ),
      ),
    );
  }
}

class SearchItems extends StatelessWidget {
  SearchItems({
    this.source,
    this.title,
    this.category,
    this.author,
    this.rating,
    this.searchKeyword,
    this.chapterNum,
  });
  final String? source;
  final String? title;
  final Widget? category;
  final String? author;
  final String? rating;
  final List<String>? searchKeyword;
  final int? chapterNum;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.0147),
      height: height * 0.1675,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xff08252B).withOpacity(.1),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ]),
      child: Row(
        children: [
          Container(
            width: width * 0.2906,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(8),
            // ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                source!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.032, vertical: height * 0.0099),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        // margin: EdgeInsets.only(top: height * 0.0098),
                        height: 24,
                        child: SubstringHighlight(
                          terms: searchKeyword,
                          text: title!,
                          textStyle: largeMediumBodyTextStyle,
                          overflow: TextOverflow.ellipsis,
                          textStyleHighlight: largeMediumBodyTextStyle.copyWith(
                              color: majorPink),
                        )),
                    SizedBox(
                      height: height * 0.0049,
                    ),
                    Container(
                      height: 18,
                      child: category,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("assets/icons/Author.png", height: 16),
                          SizedBox(width: width * 0.0106),
                          Text(
                            author!,
                            style: smallRegularBodyTextStyle,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.0049,
                    ),
                    Container(
                      height: 18,
                      child: Row(
                        children: [
                          Image.asset("assets/icons/Star.png", height: 16),
                          SizedBox(width: width * 0.0106),
                          Text(rating!,
                              style: smallRegularBodyTextStyle.copyWith(
                                  color: majorPink)),
                          Text(" Sao",
                              style: smallRegularLightBlackBodyTextStyle),
                          SizedBox(width: width * 0.0424),
                          Image.asset("assets/icons/Page.png", height: 16),
                          SizedBox(width: width * 0.0106),
                          Text(chapterNum!.toString(),
                              style: smallRegularBodyTextStyle.copyWith(
                                  color: majorPink)),
                          Text(" Ch????ng",
                              style: smallRegularLightBlackBodyTextStyle),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
