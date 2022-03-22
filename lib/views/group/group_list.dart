import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wecomi_flutter/constants/api.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font.dart';
import 'package:wecomi_flutter/view_models/service_view_models/group_list_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/login_provider.dart';
import 'package:wecomi_flutter/views/group/group_info.dart';
import 'package:wecomi_flutter/views/login/login_screen.dart';

class GroupListScreen extends StatefulWidget {
  @override
  _GroupListScreenState createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  bool isLogged = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // isLogged = context.read<LoginProvider>().isLogged;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isLogged = context.select((LoginProvider p) => p.isLogged);
    Provider.of<GroupListProvider>(context, listen: false)
        .getGroupList(isLogged);
    Provider.of<GroupListProvider>(context, listen: false)
        .getRecommendedGroupList(isLogged);
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: BackButton(
                      color: Color(0xff7f7f7f),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(right: 16, top: 4, bottom: 4),
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff08252B).withOpacity(.1),
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tìm kiếm nhóm",
                                style: regularLightBlackBodyTextStyle.copyWith(
                                    color: Color(0xff5f5f5f)),
                              ),
                              Image.asset("assets/icons/Search.png",
                                  height: 24, width: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Container(
                    child: Text("Nhóm của bạn",
                        style: extraLargeMediumBodyTextStyle.copyWith(
                          fontSize: 20,
                        )),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                // height:
                child: Consumer<GroupListProvider>(
                    builder: (context, groupListProvider, child) {
                  var myGroupList = [];
                  if (groupListProvider.groupList != null) {
                    myGroupList = groupListProvider.groupList!.data!.results!
                        .where((i) => i.joined == true)
                        .toList();
                  }
                  return Container(
                    height: 124,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: !isLogged
                          ? Center(child: Text("Bạn chưa đăng nhập"))
                          : groupListProvider.isLoading
                              ? ListView.builder(
                                  itemCount: 4,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Column(
                                        children: [
                                          Shimmer.fromColors(
                                            loop: 1,
                                            baseColor: Color(0xffE4E8EF),
                                            highlightColor: Color(0xffC9D1E0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xffE4E8EF),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              height: 100,
                                              width: 100,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Shimmer.fromColors(
                                            loop: 1,
                                            baseColor: Color(0xffE4E8EF),
                                            highlightColor: Color(0xffC9D1E0),
                                            child: Container(
                                              color: Color(0xffE4E8EF),
                                              height: 16,
                                              width: 75,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  })
                              : ListView.builder(
                                  itemCount: myGroupList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GroupInfoScreen(
                                                        name: myGroupList[index]
                                                            .name,
                                                        avatar:
                                                            myGroupList[index]
                                                                .avatar,
                                                        id: myGroupList[index]
                                                            .id,
                                                        memberCount:
                                                            myGroupList[index]
                                                                .memberCount,
                                                        hasJoined:
                                                            myGroupList[index]
                                                                .joined)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              height: 100,
                                              width: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                    myGroupList[index].avatar ==
                                                            null
                                                        ? "https://media-cdn.laodong.vn/Storage/NewsPortal/2020/12/19/863691/IU2.jpg"
                                                        : "${groupListProvider.groupList!.data!.results![index].avatar}",
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              width: 75,
                                              child: Text(
                                                  myGroupList[index].name!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      smallRegularGreyBodyTextStyle),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Container(
                    child: Text("Khám phá nhóm",
                        style: extraLargeMediumBodyTextStyle.copyWith(
                          fontSize: 20,
                        )),
                  ),
                ),
              ),
              Consumer<GroupListProvider>(
                  builder: (context, groupListProvider, _) {
                return !isLogged
                    ? SliverToBoxAdapter(
                        child: Container(
                          height: 100,
                          child: Center(
                            child: Text("Ban chua dang nhap"),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return groupListProvider.isGettingRecommededGroups
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Shimmer.fromColors(
                                          loop: 20,
                                          baseColor: Color(0xffE4E8EF),
                                          highlightColor: Color(0xffC9D1E0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffE4E8EF),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            height: 100,
                                            width: 100,
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Shimmer.fromColors(
                                                  loop: 20,
                                                  baseColor: Color(0xffE4E8EF),
                                                  highlightColor:
                                                      Color(0xffC9D1E0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffE4E8EF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    height: 18,
                                                    width: 150,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Shimmer.fromColors(
                                                            loop: 20,
                                                            baseColor: Color(
                                                                0xffE4E8EF),
                                                            highlightColor:
                                                                Color(
                                                                    0xffC9D1E0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xffE4E8EF),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              height: 16,
                                                              width: 75,
                                                            ),
                                                          ),
                                                          SizedBox(height: 12),
                                                          Shimmer.fromColors(
                                                            loop: 20,
                                                            baseColor: Color(
                                                                0xffE4E8EF),
                                                            highlightColor:
                                                                Color(
                                                                    0xffC9D1E0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xffE4E8EF),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              height: 16,
                                                              width: 150,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color(0xff08252B).withOpacity(.1),
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          height: 100,
                                          width: 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              groupListProvider
                                                      .recommederGroupList!
                                                      .results![index]
                                                      .avatar ??
                                                  "https://media-cdn.laodong.vn/Storage/NewsPortal/2020/12/19/863691/IU2.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                    groupListProvider
                                                        .recommederGroupList!
                                                        .results![index]
                                                        .name!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: mediumBodyTextStyle),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/notebook.png",
                                                                height: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                  "${groupListProvider.recommederGroupList!.results![index].postCount.toString()} bài viết",
                                                                  style:
                                                                      regularGreyTextStyle),
                                                            ],
                                                          ),
                                                          SizedBox(height: 12),
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/member.png",
                                                                height: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                  "${groupListProvider.recommederGroupList!.results![index].memberCount.toString()} thành viên",
                                                                  style:
                                                                      regularGreyTextStyle),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                            if (isLogged ==
                                                                false) {
                                                              showLoginDiaglog(
                                                                  context);
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 32,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            48),
                                                                border: Border.all(
                                                                    color:
                                                                        majorPink)),
                                                            child: Center(
                                                              child: Text(
                                                                "Nhập hội",
                                                                style: mediumBodyTextStyle
                                                                    .copyWith(
                                                                        color:
                                                                            buttonColor),
                                                              ),
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                );
                        },
                            childCount: groupListProvider
                                    .isGettingRecommededGroups
                                ? 5
                                : groupListProvider.recommederGroupList!.count),
                      );
              })
            ],
          ));
    });
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
