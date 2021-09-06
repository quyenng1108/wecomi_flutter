import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/constants/theme.dart';

class RecommentGift extends StatefulWidget {
  @override
  _RecommentGiftState createState() => _RecommentGiftState();
}

class _RecommentGiftState extends State<RecommentGift>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final ratioH = MediaQuery.of(context).size.height / 812;
    return DefaultTabController(
      length: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ThemeConfig.bgComment,
                borderRadius: BorderRadius.circular(10),
              ),
              child: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: Container(
                  child: Container(
                    color: Colors.white,
                    height: 49 * ratioH,
                    child: TabBar(
                      tabs: [
                        Tab(
                          text: 'Quà tặng',
                        ),
                        Tab(
                          text: 'Đề xuất',
                        ),
                      ],
                      labelColor: Color(0xffF05A77),
                      unselectedLabelColor: Color(0xff7F7F7F),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Color(0xffF05A77),
                      indicatorWeight: 3,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                      controller: _tabController,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 414 * ratioH,
              child: TabBarView(
                children: [_tab1(), _tab2()],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab1() {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/image.png",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tặng “Sinh nhật đáng nhớ”",
                                style: kMediumText,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 128 * ratioW,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            "19",
                                            style: textColors,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Điểm quà tháng",
                                          style: TextStyle(
                                              color: ThemeConfig.bgTextComment,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 128 * ratioW,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            "No.216",
                                            style: textColors,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "BXH quà tháng",
                                          style: TextStyle(
                                              color: ThemeConfig.bgTextComment,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 47 * ratioH),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildGift(
                      ratioW: ratioW,
                      ratioH: ratioH,
                      image: 'assets/icons/flower.png',
                      subTitle: '19 điểm',
                      title: 'Hoa',
                    ),
                    BuildGift(
                      ratioW: ratioW,
                      ratioH: ratioH,
                      image: 'assets/icons/heart-circle.png',
                      subTitle: '99 điểm',
                      title: 'Tim',
                    ),
                    BuildGift(
                      ratioW: ratioW,
                      ratioH: ratioH,
                      image: 'assets/icons/coffee.png',
                      subTitle: '199 điểm',
                      title: 'Cà Phê',
                    ),
                    BuildGift(
                      ratioW: ratioW,
                      ratioH: ratioH,
                      image: 'assets/icons/medal-star.png',
                      subTitle: '999 điểm',
                      title: 'Huy Hiệu',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 70 * ratioH),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/gift.png",
                          height: 24 * ratioH,
                          width: 24 * ratioW,
                        ),
                        Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 4 * ratioW),
                            child: Text("19/9000")),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 70 * ratioH),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4 * ratioW),
                          child: Text("-"),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4 * ratioW),
                          child: Text("1"),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4 * ratioW),
                          child: Text("+"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 70 * ratioH),
                    child: Row(
                      children: [
                        Container(
                          width: 120 * ratioW,
                          height: 50 * ratioH,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: ThemeConfig.bgColor),
                          child: TextButton(
                            onPressed: () {},
                            child: Container(
                              child: Text(
                                "Tặng quà",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab2() {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/image.png",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tặng “Sinh nhật đáng nhớ”",
                                style: kMediumText,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 128 * ratioW,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            "19",
                                            style: textColors,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Điểm quà tháng",
                                          style: TextStyle(
                                              color: ThemeConfig.bgTextComment,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 128 * ratioW,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            "No.216",
                                            style: textColors,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "BXH quà tháng",
                                          style: TextStyle(
                                              color: ThemeConfig.bgTextComment,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 62 * ratioH),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildRecomment(
                      ratioW: ratioW,
                      ratioH: ratioH,
                      title: '1 đề xuất',
                    ),
                    BuildRecomment(
                      ratioW: ratioW,
                      ratioH: ratioH,
                      title: '2 đề xuất',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 70 * ratioH),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/award.png",
                          height: 24 * ratioH,
                          width: 24 * ratioW,
                        ),
                        Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 4 * ratioW),
                            child: Text("1/90")),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 70 * ratioH),
                    child: Row(
                      children: [
                        Container(
                          width: 120 * ratioW,
                          height: 50 * ratioH,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: ThemeConfig.bgColor),
                          child: TextButton(
                            onPressed: () {},
                            child: Container(
                              child: Text(
                                "Đề xuất",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildRecomment extends StatelessWidget {
  final String title;
  const BuildRecomment({
    Key? key,
    required this.ratioW,
    required this.ratioH,
    required this.title,
  }) : super(key: key);

  final double ratioW;
  final double ratioH;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        width: 110 * ratioW,
        height: 110 * ratioH,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ThemeConfig.bgColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 11.5 * ratioH),
              child: Image.asset("assets/icons/recomment_start.png"),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 13.5 * ratioH, 0, 12 * ratioH),
              child: Text(
                title,
                style: kMediumBodyTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildGift extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  const BuildGift({
    Key? key,
    required this.ratioW,
    required this.ratioH,
    required this.image,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final double ratioW;
  final double ratioH;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80 * ratioW,
      height: 90 * ratioH,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ThemeConfig.bgColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 4),
            child: Image.asset(image),
          ),
          Text(
            title,
            style: kMediumBodyTextStyle,
          ),
          Text(
            subTitle,
            style: TextStyle(fontSize: 12, color: Color(0xffADADAD)),
          )
        ],
      ),
    );
  }
}
