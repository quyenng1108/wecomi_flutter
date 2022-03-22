import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/utils.dart';
import 'package:wecomi_flutter/models/group_post.dart';
import 'package:wecomi_flutter/view_models/service_view_models/group_post_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/views/discover/post_comment_screen.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  GroupPost? groupPost;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read<GroupPostProvider>().getGroupPosts();
      // Provider.of<BookProvider>(context, listen: false).fetBook(widget.bookID);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLoading = context.select((GroupPostProvider p) => p.isLoading);
    // bool test = context.select((GroupPostProvider p) => p.test);
    groupPost = context.watch<GroupPostProvider>().groupPost;
    bool isLogged = context.select((LoginProvider p) => p.isLogged);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                      height: height * 0.1922,
                      width: width,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                              colors: [Color(0xffB85985), Color(0xffF05A80)],
                              center: Alignment(-.95, -1.35),
                              radius: 3.5))),
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    child: Container(
                      padding: EdgeInsets.only(right: 16),
                      width: width,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 4, bottom: 4),
                              child: SizedBox(
                                height: 44,
                                // width: 278,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(48),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color(0xff08252B).withOpacity(.1),
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tìm kiếm bài viết",
                                          style: regularLightBlackBodyTextStyle
                                              .copyWith(
                                                  color: Color(0xff5f5f5f)),
                                        ),
                                        Image.asset("assets/icons/Search.png",
                                            height: 24, width: 24),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/icons/bell.png",
                                  height: 24,
                                  width: 24,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top +
                            (height * 0.0197),
                        left: width * 0.0426,
                        right: width * 0.0426),
                  ),
                  Container(
                    height: height * 0.8534,
                    margin: EdgeInsets.only(top: height * 0.1466),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: buttonColor, strokeWidth: 4),
                          )
                        : Column(
                            children: [
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Divider(
                              //   height: 4,
                              //   color: Theme.of(context).backgroundColor,
                              // ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                  
                                  child: ListView.separated(
                                      // physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      separatorBuilder: (context, index) =>
                                      Container(height: 4,
                                            color:
                                                Color(0xffF4F6F9),),
                                         
                                      itemCount: groupPost!.results!.length,
                                      itemBuilder: (context, index) {
                                        List<bool> isLiked = context
                                            .watch<GroupPostProvider>()
                                            .isLiked;
                                
                                        return 
                                            // ? Container(
                                            //     height: 100,
                                            //     decoration: BoxDecoration(
                                            //         color: Colors.white,
                                            //         borderRadius: BorderRadius.only(
                                            //             topLeft: Radius.circular(24),
                                            //             topRight:
                                            //                 Radius.circular(24))),
                                            //     child: GestureDetector(
                                            //       onTap: () {
                                            //         context
                                            //             .read<GroupPostProvider>()
                                            //             .testPressed();
                                            //       },
                                            //       child: Container(
                                            //           height: 50,
                                            //           child: Center(
                                            //               child:
                                            //                   Text("Nơi đăng status"))
                                            //           // color: test
                                            //           //     ? Colors.red
                                            //           //     : Colors.black,
                                            //           ),
                                            //     ),
                                            //   )
                                            index == 2
                                                ? Container(
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 24, 16, 24),
                                                      child: Column(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Text(
                                                                        "Gợi ý nhóm",
                                                                        style: headingTextStyle.copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                  ),
                                                                  GestureDetector(
                                                                    child: Text(
                                                                        "Xem tất cả >",
                                                                        style:
                                                                            smallRegularGreyBodyTextStyle),
                                                                    onTap: () {},
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 16,
                                                              ),
                                                              Container(
                                                                height: 196,
                                                                child: ListView
                                                                    .builder(
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemCount:
                                                                            10,
                                                                        itemBuilder: (context,
                                                                                index) =>
                                                                            Padding(
                                                                              padding:
                                                                                  const EdgeInsets.only(left: 8),
                                                                              child:
                                                                                  Container(
                                                                                height: 196,
                                                                                width: 136,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Theme.of(context).backgroundColor, width: 2)),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Container(
                                                                                            height: 64,
                                                                                            width: 64,
                                                                                            child: ClipRRect(
                                                                                              borderRadius: BorderRadius.circular(40),
                                                                                              child: Image.asset('assets/images/group_avatar_sample.png'),
                                                                                            ),
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 12,
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                                            child: Text(
                                                                                              "Tổng tài bá đạo",
                                                                                              style: mediumBodyTextStyle,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                            ),
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 4,
                                                                                          ),
                                                                                          Text("703 bài viết", style: regularTextStyle.copyWith(color: Color(0xff999999))),
                                                                                          SizedBox(height: 16),
                                                                                          ConstrainedBox(
                                                                                            constraints: BoxConstraints.tightFor(height: 32, width: 120),
                                                                                            child: ElevatedButton(
                                                                                              onPressed: () {},
                                                                                              style: ElevatedButton.styleFrom(shadowColor: Colors.transparent, elevation: 0, primary: buttonColor, onPrimary: Color(0xffB85985), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48))),
                                                                                              child: Text("Nhập hội", style: smallTitleTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                        top: 8,
                                                                                        right: 8,
                                                                                        child: InkWell(
                                                                                            onTap: () {},
                                                                                            child: Icon(
                                                                                              Icons.close,
                                                                                              color: Color(0xff999999),
                                                                                            )))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 24, 0, 0),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  height: 36,
                                                                  width: 36,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                24),
                                                                    child: groupPost!.results![index].avatar !=
                                                                            ''
                                                                        ? Image.network(
                                                                            "$apiUrlNoSlash${groupPost!.results![index].avatar!}")
                                                                        : Image.asset(
                                                                            "assets/images/Avatar-Placeholder.png"),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                // Spacer(),
                                                                Expanded(
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          groupPost!
                                                                              .results![index]
                                                                              .group!,
                                                                          style:
                                                                              mediumBodyTextStyle,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4,
                                                                        ),
                                                                        RichText(
                                                                          text: TextSpan(
                                                                              style:
                                                                                  regularGreyTextStyle,
                                                                              children: [
                                                                                TextSpan(text: "${groupPost!.results![index].user} • "),
                                                                                TextSpan(
                                                                                  text: Utils.timeElasped(groupPost!.results![index].dateModified!),
                                                                                  style: regularGreyTextStyle.copyWith(color: Color(0xff999999)),
                                                                                )
                                                                              ]),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Spacer(),
                                                                Image.asset(
                                                                  "assets/icons/menu.png",
                                                                  width: 20,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 10,
                                                                    horizontal:
                                                                        16),
                                                            child: Text(
                                                              groupPost!
                                                                  .results![index]
                                                                  .content!,
                                                              style:
                                                                  regularBodyTextStyle,
                                                            ),
                                                          ),
                                                          Container(
                                                            child:
                                                                CachedNetworkImage(
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          downloadProgress) =>
                                                                      Container(
                                                                height: 80,
                                                                child: Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color:
                                                                        buttonColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              imageUrl:
                                                                  '$apiUrlNoSlash${groupPost!.results![index].imageUrl!}',
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical: 12),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/icons/like.png",
                                                                      height: 16,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    Text(
                                                                        '${groupPost!.results![index].likeCount} lượt thích',
                                                                        style: smallRegularLightBlackBodyTextStyle.copyWith(
                                                                            color:
                                                                                Color(0xff999999))),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        '${groupPost!.results![index].commentCount} bình luận',
                                                                        style: smallRegularLightBlackBodyTextStyle.copyWith(
                                                                            color:
                                                                                Color(0xff999999))),
                                                                    SizedBox(
                                                                      width: 12,
                                                                    ),
                                                                    Text(
                                                                        '${groupPost!.results![index].shareCount} chia sẻ',
                                                                        style: smallRegularLightBlackBodyTextStyle.copyWith(
                                                                            color:
                                                                                Color(0xff999999))),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                              height: 2,
                                                              color: Theme.of(
                                                                      context)
                                                                  .backgroundColor),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Material(
                                                                    type: MaterialType
                                                                        .transparency,
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          majorPink,
                                                                      onTap: () {
                                                                        // print(
                                                                        //     isLiked);
                                                                        // context
                                                                        //     .read<
                                                                        //         GroupPostProvider>()
                                                                        //     .likePressed(
                                                                        //         index);
                                                                        print(isLiked[
                                                                            index]);
                                                                        if (isLogged ==
                                                                            false) {
                                                                          showLoginDiaglog(
                                                                              context);
                                                                        } else {
                                                                          context.read<GroupPostProvider>().like(
                                                                              index,
                                                                              isLiked[index],
                                                                              groupPost!.results![index].id!);
                                                                          context
                                                                              .read<GroupPostProvider>()
                                                                              .likePressed(index);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                                border: Border(right: BorderSide(color: Theme.of(context).backgroundColor, width: 1.5))),
                                                                        height:
                                                                            44,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            isLiked[index]
                                                                                ? Image.asset(
                                                                                    "assets/icons/like.png",
                                                                                    height: 20,
                                                                                  )
                                                                                : Image.asset(
                                                                                    "assets/icons/like_outline.png",
                                                                                    height: 20,
                                                                                  ),
                                                                            SizedBox(
                                                                                width: 8),
                                                                            Text(
                                                                                "Thích",
                                                                                style: smallRegularLightBlackBodyTextStyle.copyWith(color: Color(0xff5f5f5f)))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Material(
                                                                    type: MaterialType
                                                                        .transparency,
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          majorPink,
                                                                      onTap: () {
                                                                        Navigator.of(context).push(CupertinoPageRoute(
                                                                            builder: (context) => PostCommentScreen(
                                                                                index: index,
                                                                                id: groupPost!.results![index].id!)));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                                border: Border(right: BorderSide(color: Theme.of(context).backgroundColor, width: 1.5))),
                                                                        height:
                                                                            44,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Image
                                                                                .asset(
                                                                              "assets/icons/message.png",
                                                                              height:
                                                                                  20,
                                                                            ),
                                                                            SizedBox(
                                                                                width: 8),
                                                                            Text(
                                                                                "Bình luận",
                                                                                style: smallRegularLightBlackBodyTextStyle.copyWith(color: Color(0xff5f5f5f)))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    // decoration: BoxDecoration(border:Border(
                                                                    //   right: BorderSide(
                                                                    //     color: Theme.of(context).backgroundColor,
                                                                    //     width: 1.5
                                                                    //   )
                                                                    // ) ),
                                                                    height: 44,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/icons/share_purple.png",
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                8),
                                                                        Text(
                                                                            "Chia sẻ",
                                                                            style:
                                                                                smallRegularLightBlackBodyTextStyle.copyWith(color: Color(0xff5f5f5f)))
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                      }),
                                ),
                              ),
                            ],
                          ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Future<dynamic> showLoginDiaglog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: CupertinoAlertDialog(
                title: Text("Vui lòng đăng nhập"),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
                      child: Text("Hủy", style: defaultActionStyle)),
                  CupertinoDialogAction(
                      isDefaultAction: false,
                      child: Text("Đăng nhập", style: nonDefaultActionStyle),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                        // Provider.of<FollowBookProvider>(
                        //         context)
                        //     .followedBook = null;
                      }),
                ]),
          );
        });
  }
}
