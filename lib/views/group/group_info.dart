import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font.dart';
import 'package:wecomi_flutter/view_models/service_view_models/group_info_provider.dart';

class GroupInfoScreen extends StatefulWidget {
  GroupInfoScreen(
      {required this.name,
      required this.avatar,
      required this.id,
      required this.memberCount,
      required this.hasJoined});
  String name;
  String avatar;
  int id;
  int memberCount;
  bool hasJoined;
  @override
  _GroupInfoScreenState createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<GroupInfoProvider>().getGroupPost(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLoading = context.select((GroupInfoProvider p) => p.isLoading);
    return Scaffold(
      body: DefaultTabController(
          length: 2,
          child: Consumer<GroupInfoProvider>(
            builder: (context, groupInfoProvider, child) => NestedScrollView(
              headerSliverBuilder: (context, isBodyScrolled) => [
                SliverAppBar(
                  backgroundColor: buttonColor.withOpacity(.95),
                  expandedHeight: 360,
                  leading: BackButton(),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Image.asset(
                        'assets/icons/menu_white.png',
                        width: 20,
                      ),
                    )
                  ],
                  elevation: 3.0,
                  pinned: true,
                  snap: false,
                  primary: true,
                  floating: false,
                  // forceElevated: isBodyScrolled,
                  // automaticallyImplyLeading: true,
                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    var top = constraints.maxHeight;
                    // print(top);
                    // print(constraints.);
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 48),
                        child: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            titlePadding: EdgeInsetsDirectional.only(
                              start: 0.0,
                              bottom: top > 151 ? 76 : 16,
                            ),
                            centerTitle: true,
                            title:
                                // AnimatedOpacity(
                                //     duration: Duration(milliseconds: 300),
                                //     //opacity: top == MediaQuery.of(context).padding.top + kToolbarHeight ? 1.0 : 0.0,
                                //     opacity: 1.0,
                                //     child:
                                Text(
                              widget.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: top > 151 ? 14 : 20,
                                  color: Color(0xff373737)),
                              // )
                            ),
                            background: Stack(children: [
                              Container(
                                  width: double.infinity,
                                  height: 250,
                                  child: isLoading
                                      ? Container(
                                          color: Colors.grey,
                                        )
                                      : Image.asset(
                                          "assets/images/sample_image.png",
                                          fit: BoxFit.fill)),
                              Positioned(
                                bottom: 0,
                                height: 220,
                                width: width,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(28),
                                          topRight: Radius.circular(28))),
                                  // height: 200,
                                ),
                              ),
                              Positioned(
                                  bottom: 170,
                                  height: 100,
                                  width: width,
                                  child: Center(
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle
                                          // borderRadius: BorderRadius.circular(60)
                                          ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage:
                                                NetworkImage(widget.avatar)),
                                      ),
                                    ),
                                  )),
                              Positioned(
                                  bottom: 168,
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 34),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                isLoading
                                                    ? '---'
                                                    : groupInfoProvider
                                                        .groupPost!
                                                        .results!
                                                        .length
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: Color(0xffB85985))),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              'Bài đăng',
                                              style:
                                                  smallRegularGreyBodyTextStyle
                                                      .copyWith(
                                                          color: Color(
                                                              0xff5f5f5f)),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                isLoading
                                                    ? '---'
                                                    : widget.memberCount
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: Color(0xffB85985))),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              'Thành viên',
                                              style:
                                                  smallRegularGreyBodyTextStyle
                                                      .copyWith(
                                                          color: Color(
                                                              0xff5f5f5f)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                width: width,
                                bottom: 70,
                                child: Container(
                                  // width: double.infinity,
                                  child: Center(
                                    child: SizedBox(
                                      height: 40,
                                      width: 226,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            // if (isLogged == false) {
                                            //   showLoginDiaglog(context);
                                            // } else {
                                            //   context
                                            //       .read<UserProfileProvider>()
                                            //       .follow();
                                            // }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shadowColor: Colors.transparent,
                                              elevation: 0,
                                              primary: buttonColor,
                                              onPrimary: Color(0xffB85985),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          48))),
                                          child: Text(
                                              widget.hasJoined
                                                  ? 'Rời khỏi'
                                                  : 'Tham gia',
                                              style:
                                                  smallRegularWhiteBodyTextStyle
                                                      .copyWith(
                                                          fontWeight: FontWeight
                                                              .w800))),
                                    ),
                                  ),
                                ),
                              )
                            ])));
                  }),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(40),
                    child: Container(
                      color: Colors.white,
                      height: 48,
                      child: TabBar(
                        tabs: [
                          Tab(
                            text: 'Bài viết',
                          ),
                          Tab(
                            text: 'Truyện tranh',
                          ),
                        ],
                        labelPadding: EdgeInsets.zero,
                        labelStyle: mediumBodyTextStyle.copyWith(
                            color: Color(0xff7f7f7f)),
                        labelColor: Color(0xffF05A77),
                        unselectedLabelColor: Color(0xff7F7F7F),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Color(0xffF05A77),
                        indicatorWeight: 3,
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 0),
                        controller: _tabController,
                      ),
                    ),
                  ),
                )
              ],
              body: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                      child: isLoading
                          ? GridView.builder(
                              padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      // mainAxisSpacing: 8,
                                      // crossAxisSpacing: 8,
                                      childAspectRatio: 168 / 196,
                                      crossAxisCount: (2)),
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        elevation: 0,
                                        color: Colors.red,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.asset(
                                                  "assets/images/sample_image.png",
                                                  fit: BoxFit.cover),
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  height: 40,
                                                  // width: 196,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8)),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )
                                      // Container(
                                      //   height: 204,
                                      //   decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(8),
                                      //       color: Colors.red),
                                      //   child: ClipRRect(
                                      //     borderRadius: BorderRadius.circular(8),
                                      //     child: Image.asset(
                                      //         "assets/images/sample_image.png",
                                      //         fit: BoxFit.cover),
                                      //   ),
                                      // ),
                                      // Positioned(
                                      //     bottom: 0,
                                      //     width: 176,
                                      //     height: 40,
                                      //     child: Container(
                                      //       // width: 196,
                                      //       decoration: BoxDecoration(
                                      //           borderRadius: BorderRadius.only(
                                      //               bottomLeft: Radius.circular(8),
                                      //               bottomRight: Radius.circular(8)),
                                      //           color: Colors.black.withOpacity(.3)),
                                      //       child: Padding(
                                      //         padding:
                                      //             EdgeInsets.symmetric(horizontal: 8),
                                      //         child: Row(
                                      //           // mainAxisAlignment: MainAxisAlignment.center,
                                      //           children: [
                                      //             Image.asset(
                                      //                 'assets/icons/like_2.png',
                                      //                 height: 16),
                                      //             SizedBox(
                                      //               width: 4,
                                      //             ),
                                      //             Text("253",
                                      //                 style:
                                      //                     smallRegularWhiteBodyTextStyle),
                                      //             SizedBox(
                                      //               width: 4,
                                      //             ),
                                      //             Expanded(
                                      //                 child: Text(
                                      //                     'Hội yêu thích bla bla bla',
                                      //                     overflow:
                                      //                         TextOverflow.ellipsis,
                                      //                     style:
                                      //                         smallRegularWhiteBodyTextStyle))
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ))

                                      ),
                                  loop: 1,
                                  period: Duration(milliseconds: 700),
                                  baseColor: Color(0xffE4E8EF),
                                  highlightColor: Color(0xffC9D1E0),
                                );
                              })
                          : groupInfoProvider.groupPost!.results!.isEmpty
                              ? Center(
                                  child: Text(
                                      'Người dùng này không có bài viết nào'),
                                )
                              : GridView.builder(
                                  padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
                                  itemCount: groupInfoProvider
                                      .groupPost!.results!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          // mainAxisSpacing: 8,
                                          // crossAxisSpacing: 8,
                                          childAspectRatio: 168 / 196,
                                          crossAxisCount: (2)),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          elevation: 0,
                                          // color: Colors.red,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: CachedNetworkImage(
                                                      imageUrl:
                                                          '$apiUrlNoSlash${groupInfoProvider.groupPost!.results![index].imageUrl!}',
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color:
                                                                      majorPink,
                                                                ),
                                                              ),
                                                      fit: BoxFit.cover)),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 40,
                                                    // width: 196,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            8)),
                                                        color: Colors.black
                                                            .withOpacity(.3)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Image.asset(
                                                              'assets/icons/like_2.png',
                                                              height: 16),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                              groupInfoProvider
                                                                  .groupPost!
                                                                  .results![
                                                                      index]
                                                                  .likeCount!
                                                                  .toString(),
                                                              style:
                                                                  smallRegularWhiteBodyTextStyle),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Expanded(
                                                              child: Text(
                                                                  groupInfoProvider
                                                                      .groupPost!
                                                                      .results![
                                                                          index]
                                                                      .user!,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      smallRegularWhiteBodyTextStyle))
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )
                                        // Container(
                                        //   height: 204,
                                        //   decoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.circular(8),
                                        //       color: Colors.red),
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.circular(8),
                                        //     child: Image.asset(
                                        //         "assets/images/sample_image.png",
                                        //         fit: BoxFit.cover),
                                        //   ),
                                        // ),
                                        // Positioned(
                                        //     bottom: 0,
                                        //     width: 176,
                                        //     height: 40,
                                        //     child: Container(
                                        //       // width: 196,
                                        //       decoration: BoxDecoration(
                                        //           borderRadius: BorderRadius.only(
                                        //               bottomLeft: Radius.circular(8),
                                        //               bottomRight: Radius.circular(8)),
                                        //           color: Colors.black.withOpacity(.3)),
                                        //       child: Padding(
                                        //         padding:
                                        //             EdgeInsets.symmetric(horizontal: 8),
                                        //         child: Row(
                                        //           // mainAxisAlignment: MainAxisAlignment.center,
                                        //           children: [
                                        //             Image.asset(
                                        //                 'assets/icons/like_2.png',
                                        //                 height: 16),
                                        //             SizedBox(
                                        //               width: 4,
                                        //             ),
                                        //             Text("253",
                                        //                 style:
                                        //                     smallRegularWhiteBodyTextStyle),
                                        //             SizedBox(
                                        //               width: 4,
                                        //             ),
                                        //             Expanded(
                                        //                 child: Text(
                                        //                     'Hội yêu thích bla bla bla',
                                        //                     overflow:
                                        //                         TextOverflow.ellipsis,
                                        //                     style:
                                        //                         smallRegularWhiteBodyTextStyle))
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ))

                                        );
                                  })),
                  Scaffold(
                    body: Center(
                      child: Text("Chức năng đang phát triển"),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
