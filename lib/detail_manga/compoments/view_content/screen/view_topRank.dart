import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/components/bottom_nav_bar_icon.dart';
import 'package:wecomi_flutter/constants/theme.dart';

class topRank extends StatefulWidget {
  const topRank({Key? key}) : super(key: key);

  @override
  _topRankState createState() => _topRankState();
}

class _topRankState extends State<topRank> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;

    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  title: Text(
                    'Nàng Ther',
                    style: TextStyle(color: Colors.white),
                  ),
                  stretch: true,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  actions: [
                    IconButton(
                      color: Colors.green,
                      icon: CustomizedBottomNavBarIcon(
                          source: "assets/images/Received.png",
                          size: 20 * ratioH),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/bg.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      stretchModes: <StretchMode>[
                        StretchMode.zoomBackground,
                      ],
                    ),
                  ),
                  backgroundColor: ThemeConfig.bgColor,
                  elevation: 3.0,
                  pinned: true,
                  snap: false,
                  primary: true,
                  forceElevated: innerBoxIsScrolled,
                  automaticallyImplyLeading: true,
                  expandedHeight: ratioH * 192,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(40),
                    child: Container(
                      child: Container(
                        color: Colors.white,
                        height: 51 * ratioH,
                        child: TabBar(
                          tabs: [
                            Tab(
                              text: 'BXH Tuần',
                            ),
                            Tab(
                              text: 'BXH Chung',
                            ),
                          ],
                          labelColor: Color(0xffF05A77),
                          unselectedLabelColor: Color(0xff7F7F7F),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(0xffF05A77),
                          indicatorWeight: 3,
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                          controller: _tabController,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [_tab1(), _tab2()],
          ),
        ),
      ),
    );
  }

  Widget _tab1() {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(46, 32, 46, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildRank(
                  image: 'assets/images/bxhno3.png',
                  rank: 'assets/images/top3.png',
                  sizeImage: 35,
                  sizeRaidius: 38,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.pink,
                ),
                buildRank(
                  image: 'assets/images/bxhno1.png',
                  rank: 'assets/images/top1.png',
                  sizeImage: 40,
                  sizeRaidius: 45,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.amber,
                ),
                buildRank(
                  image: 'assets/images/bxhno2.png',
                  rank: 'assets/images/top2.png',
                  sizeImage: 35,
                  sizeRaidius: 38,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.pink,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return buildBXH();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab2() {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(46, 32, 46, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildRank(
                  image: 'assets/images/bxhno3.png',
                  rank: 'assets/images/top3.png',
                  sizeImage: 35,
                  sizeRaidius: 38,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.pink,
                ),
                buildRank(
                  image: 'assets/images/bxhno1.png',
                  rank: 'assets/images/top1.png',
                  sizeImage: 40,
                  sizeRaidius: 45,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.amber,
                ),
                buildRank(
                  image: 'assets/images/bxhno2.png',
                  rank: 'assets/images/top2.png',
                  sizeImage: 35,
                  sizeRaidius: 38,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.pink,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return buildBXH();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class buildBXH extends StatelessWidget {
  const buildBXH({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Text(
                  "04",
                  style: TextStyle(color: Color(0xff999999)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/images/bxhno2.png"),
                  ),
                ),
                Text("Trúc Lâm"),
              ],
            ),
          ),
          Text(
            "Điểm fan: 256",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff999999),
            ),
          ),
        ],
      ),
    );
  }
}

class buildRank extends StatelessWidget {
  final String image;
  final String rank;
  final String name;
  final String total;
  final double sizeRaidius;
  final double sizeImage;
  final Color color;
  const buildRank({
    Key? key,
    required this.image,
    required this.rank,
    required this.name,
    required this.total,
    required this.sizeRaidius,
    required this.sizeImage,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: sizeRaidius,
              backgroundColor: color,
              child: CircleAvatar(
                radius: sizeImage,
                backgroundImage: AssetImage(image),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(rank),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Text(name),
              Text(
                total,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}