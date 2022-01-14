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
import 'package:wecomi_flutter/models/post_comment.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comment_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/group_post_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';
import 'package:wecomi_flutter/views/user_profile/user_profile_screen.dart';

class PostCommentScreen extends StatefulWidget {
  PostCommentScreen({required this.index, required this.id});
  final int index;
  final int id;
  @override
  _PostCommentScreenState createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
  PostData? postData;
  List<CommentData>? commentData;
  TextEditingController commentController = TextEditingController();
  TextEditingController replyCommentController = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusScopeNode focusNode = FocusScopeNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      // if (Provider.of<CommentProvider>(context, listen: false).postComment ==
      //     null) {
      Provider.of<CommentProvider>(context, listen: false)
          .getPostComment(widget.id);
      // }
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    replyCommentController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // postData =
    postData =
        context.watch<GroupPostProvider>().groupPost!.results![widget.index];
    bool isLiked = context.watch<GroupPostProvider>().isLiked[widget.index];
    commentData = context.watch<CommentProvider>().postComment?.results;
    bool isLoading = context.select((CommentProvider p) => p.isLoading);
    bool isLogged = context.select((LoginProvider p) => p.isLogged);
    // print(postData!.content);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      child: BackButton(
                        color: Color(0xff7f7f7f),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: postData!.avatar != ''
                            ? Image.network(
                                "$apiUrlNoSlash${postData!.avatar!}")
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
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postData!.group!,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: regularGreyTextStyle,
                                  children: [
                                    TextSpan(
                                        text: "${postData!.user} • ",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print(postData!.id!);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserProfileScreen(
                                                            userId: postData!
                                                                .id!)));
                                          }),
                                    TextSpan(
                                      text: Utils.timeElasped(
                                          postData!.dateModified!),
                                      // Utils.timeElasped(groupPost!.results![index].dateAdded!),
                                      style: regularGreyTextStyle.copyWith(
                                          color: Color(0xff999999)),
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
              Expanded(
                // child: Scrollbar(
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                postData!.content!,
                                style: regularBodyTextStyle,
                              ),
                            ),
                          ),
                          Container(
                            child: CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(
                                          height: 80,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: buttonColor,
                                            ),
                                          ),
                                        ),
                                imageUrl:
                                    '$apiUrlNoSlash${postData!.imageUrl!}'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Text('${postData!.likeCount} lượt thích',
                                        style:
                                            smallRegularLightBlackBodyTextStyle
                                                .copyWith(
                                                    color: Color(0xff999999))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('${postData!.commentCount} bình luận',
                                        // '${groupPost!.results![index].commentCount} bình luận',
                                        style:
                                            smallRegularLightBlackBodyTextStyle
                                                .copyWith(
                                                    color: Color(0xff999999))),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text('${postData!.shareCount} chia sẻ',
                                        // '${groupPost!.results![index].shareCount} chia sẻ',
                                        style:
                                            smallRegularLightBlackBodyTextStyle
                                                .copyWith(
                                                    color: Color(0xff999999))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                              height: 1.5,
                              color: Theme.of(context).backgroundColor),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      splashColor: majorPink,
                                      onTap: () {
                                        context
                                            .read<GroupPostProvider>()
                                            .like(widget.index, isLiked);
                                        context
                                            .read<GroupPostProvider>()
                                            .likePressed(widget.index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                    width: 1.5))),
                                        height: 44,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            isLiked
                                                ? Image.asset(
                                                    "assets/icons/like.png",
                                                    height: 20,
                                                  )
                                                : Image.asset(
                                                    "assets/icons/like_outline.png",
                                                    height: 20,
                                                  ),
                                            SizedBox(width: 8),
                                            Text("Thích",
                                                style:
                                                    smallRegularLightBlackBodyTextStyle
                                                        .copyWith(
                                                            color: Color(
                                                                0xff5f5f5f)))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      splashColor: buttonColor,
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                    width: 1.5))),
                                        height: 44,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icons/message.png",
                                              height: 20,
                                            ),
                                            SizedBox(width: 8),
                                            Text("Bình luận",
                                                style:
                                                    smallRegularLightBlackBodyTextStyle
                                                        .copyWith(
                                                            color: Color(
                                                                0xff5f5f5f)))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    // decoration: BoxDecoration(border:Border(
                                    //   right: BorderSide(
                                    //     color: Theme.of(context).backgroundColor,
                                    //     width: 1.5
                                    //   )
                                    // ) ),
                                    height: 44,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icons/share_purple.png",
                                          height: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text("Chia sẻ",
                                            style:
                                                smallRegularLightBlackBodyTextStyle
                                                    .copyWith(
                                                        color:
                                                            Color(0xff5f5f5f)))
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          Divider(
                              height: 1.5,
                              color: Theme.of(context).backgroundColor),
                        ],
                      ),
                    ),
                    isLoading
                        ? SliverToBoxAdapter(
                            child: Container(
                              height: 120,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: buttonColor,
                                ),
                              ),
                            ),
                          )
                        : commentData!.length == 0 || commentData == null
                            ? SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 24),
                                  // height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Chưa có comment nào",
                                          style: smallHeadingTextStyle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: lightBlack)),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text("Hãy trở thành người đầu tiên",
                                          style: regularLightBlackBodyTextStyle)
                                    ],
                                  ),
                                ),
                              )
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Builder(builder: (context) {
                                    List<bool> isGettingMoreReplies =
                                        context.select((CommentProvider p) =>
                                            p.isGettingMoreReplies);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  print(
                                                      commentData![index].user);
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserProfileScreen(
                                                                  userId: commentData![
                                                                          index]
                                                                      .user!)));
                                                },
                                                child: Container(
                                                  height: 32,
                                                  width: 32,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    child: commentData![index]
                                                                .avatar ==
                                                            ''
                                                        ? Image.asset(
                                                            'assets/images/Avatar-Placeholder.png')
                                                        : CachedNetworkImage(
                                                            imageUrl:
                                                                "$apiUrlNoSlash${commentData![index].avatar!}"),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                  child: Container(
                                                // height: 72,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffEEF0F1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          commentData![index]
                                                              .name!,
                                                          style:
                                                              mediumBodyTextStyle),
                                                      Text(
                                                          commentData![index]
                                                              .content!,
                                                          style: regularExtraLightBlackBodyTextStyle
                                                              .copyWith(
                                                                  color: Color(
                                                                      0xff5f5f5f))),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Image.asset(
                                                            'assets/icons/like_outline.png',
                                                            height: 16,
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(commentData![
                                                                  index]
                                                              .likeCount!
                                                              .toString())
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                            ],
                                          ),
                                          commentData![index].reply != null
                                              // ? isGettingMoreReplies[index]
                                              //     ? Row(
                                              //         mainAxisAlignment:
                                              //             MainAxisAlignment
                                              //                 .center,
                                              //         children: [
                                              //           Padding(
                                              //             padding:
                                              //                 const EdgeInsets
                                              //                         .symmetric(
                                              //                     vertical: 12),
                                              //             child: SizedBox(
                                              //               height: 16,
                                              //               width: 16,
                                              //               child:
                                              //                   CircularProgressIndicator(
                                              //                 strokeWidth: 2,
                                              //                 color: buttonColor,
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       )
                                              //     :
                                              ? Column(
                                                  children: [
                                                    commentData![index]
                                                                    .replyCount! >
                                                                1 &&
                                                            commentData![index]
                                                                    .reply!
                                                                    .length <=
                                                                1
                                                        ? Row(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                   if(!isGettingMoreReplies[
                                                                      index])context
                                                                      .read<
                                                                          CommentProvider>()
                                                                      .getMoreReplies(
                                                                          commentData![index]
                                                                              .id!,
                                                                          index);
                                                                },
                                                                child:
                                                                    Container(
                                                                  // width: double
                                                                  //     .infinity,
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          72,
                                                                          12,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    "Tải thêm ${commentData![index].replyCount! - 1} bình luận",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: regularExtraLightBlackBodyTextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                majorPink),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 12),
                                                              isGettingMoreReplies[
                                                                      index]
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              12),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            16,
                                                                        width:
                                                                            16,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              2,
                                                                          color:
                                                                              buttonColor,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : SizedBox()
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                    for (int i = 0;
                                                        i <
                                                            commentData![index]
                                                                .reply!
                                                                .length;
                                                        i++)
                                                      commentData![index]
                                                                  .reply![i]
                                                                  .user !=
                                                              null
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      40,
                                                                      12,
                                                                      0,
                                                                      0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      print(commentData![
                                                                              index]
                                                                          .user);
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(builder: (context) => UserProfileScreen(userId: commentData![index].reply![i].userId!)));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          24,
                                                                      width: 24,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(40),
                                                                        child: commentData![index].reply![i].avatar ==
                                                                                ''
                                                                            ? Image.asset('assets/images/Avatar-Placeholder.png')
                                                                            : CachedNetworkImage(imageUrl: "$apiUrlNoSlash${commentData![index].reply![i].avatar!}"),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          Container(
                                                                    // height: 72,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xffEEF0F1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(16)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              8,
                                                                          horizontal:
                                                                              12),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              commentData![index].reply![i].userName!,
                                                                              style: mediumBodyTextStyle),
                                                                          Text(
                                                                              commentData![index].reply![i].reply!,
                                                                              style: regularExtraLightBlackBodyTextStyle.copyWith(color: Color(0xff5f5f5f))),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Image.asset(
                                                                                'assets/icons/like_outline.png',
                                                                                height: 16,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 4,
                                                                              ),
                                                                              Text(commentData![index].reply![i].likeCount!.toString())
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )),
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox()
                                                  ],
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    );
                                  });
                                },
                                childCount: commentData!.length,
                              ))
                  ],
                ),
                // )
              ),
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border( top: BorderSide(
                  //   width: 1.5,
                  //   color: Theme.of(context).backgroundColor
                  // )),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff18274B).withOpacity(.02),
                        offset: Offset(0, -3),
                        spreadRadius: 1,
                        blurRadius: 0),
                    // BoxShadow(
                    //     color: Color(0xff18274B).withOpacity(.12),
                    //     offset: Offset(0, -1),
                    //     spreadRadius: -6,
                    //     blurRadius: 0)
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                          focusNode: focusNode,
                          onTap: () {
                            if (isLogged == false) {
                              focusNode.unfocus();
                              showLoginDiaglog(context).then((value) => focusNode.unfocus());
                            }
                          },
                          onSubmitted: (value) {
                            commentController.clear();
                            context
                                .read<GroupPostProvider>()
                                .commentAdded(widget.index);
                            context.read<CommentProvider>().comment(value).then(
                                (value) => scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut));
                          },
                          style: regularExtraLightBlackBodyTextStyle,
                          controller: commentController,
                          autocorrect: false,
                          cursorHeight: 14,
                          placeholder: 'Viết bình luận...',
                          cursorColor: buttonColor,
                          padding: EdgeInsets.only(
                              left: 12, top: 8, bottom: 8, right: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xffEEF0F1)
                              // border: Border.all(
                              //   width: .5
                              // )
                              )),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset("assets/icons/send.png", height: 24),
                  ],
                ),
              ),
            ]),
          ),
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
                                              child: Text("Hủy",
                                                  style: defaultActionStyle)),
                                          CupertinoDialogAction(
                                              isDefaultAction: false,
                                              child: Text("Đăng nhập",
                                                  style:
                                                      nonDefaultActionStyle),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()));
                                                // Provider.of<FollowBookProvider>(
                                                //         context)
                                                //     .followedBook = null;
                                              }),
                                        ]),
                                  );
                                });
  }
}
