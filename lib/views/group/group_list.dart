import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font.dart';

class GroupListScreen extends StatefulWidget {
  @override
  _GroupListScreenState createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
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
                  padding: const EdgeInsets.only(right: 16, top: 4, bottom: 4),
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
              child: Container(
                height: 124,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8)),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Hội nữ cường",
                                  style: smallRegularGreyBodyTextStyle)
                            ],
                          ),
                        );
                      }),
                ),
              ),
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
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff08252B).withOpacity(.1),
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
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8)),
                          height: 100,
                          width: 100,
                        ),
                        Expanded(
                            child: Container(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Đam mỹ là chân ái",
                                    style: mediumBodyTextStyle),
                                SizedBox(
                                  height: 12,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                              Text("1k9 bài viết",
                                                  style: regularGreyTextStyle),
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
                                              Text("10k2 thành viên",
                                                  style: regularGreyTextStyle),
                                            ],
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: () {},
                                          child: Container(
                                            height: 32,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(48),
                                                border: Border.all(
                                                    color: majorPink)),
                                            child: Center(
                                              child: Text(
                                                "Nhập hội",
                                                style: mediumBodyTextStyle
                                                    .copyWith(
                                                        color: buttonColor),
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
              }, childCount: 18),
            )
          ],
        ));
  }
}
