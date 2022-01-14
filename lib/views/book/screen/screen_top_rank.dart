import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';
import 'package:wecomi_flutter/components/bottom_nav_bar_icon.dart';
import 'package:wecomi_flutter/components/linked_offset_widget.dart';
import 'package:wecomi_flutter/constants/theme.dart';
import 'package:wecomi_flutter/models/comics.dart';
import 'package:wecomi_flutter/view_models/service_view_models/book_provider.dart';

class TopRank extends StatefulWidget {
  const TopRank({@required this.comicDetail});
  final ComicDetail? comicDetail;

  @override
  _TopRankState createState() => _TopRankState();
}

class _TopRankState extends State<TopRank> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  List _image = [
    'assets/images/bxhno1.png',
    'assets/images/bxhno2.png',
    'assets/images/bxhno3.png'
  ];
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    final List<Tuple3> _page = [
      Tuple3(widget.comicDetail!.title,
          '${widget.comicDetail!.dateModified}', ''),
      Tuple3(widget.comicDetail!.title, '', '')
    ];
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
                    'BXH FAN',
                    style: TextStyle(color: Colors.white),
                  ),
                  stretch: true,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      color: Colors.green,
                      icon: CustomizedBottomNavBarIcon(
                          source: "assets/icons/Received.png",
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
                        child:
                            // Consumer<BookProvider>(
                            //   builder: (context, bookProvider, child) {
                            //     return bookProvider.book.length == 0 &&
                            //             !bookProvider.isLoading
                            //         ? LinearProgressIndicator()
                            //         : bookProvider.isLoading
                            //             ? Shimmer.fromColors(
                            //                 child: Container(),
                            //                 baseColor: Colors.grey[300]!,
                            //                 highlightColor: Colors.grey[100]!)
                            //             :
                            Container(
                          child: Image.network(
                              '${widget.comicDetail!.thumbnail}',
                              fit: BoxFit.cover),
                          //             );
                          // },
                        ),
                      ),
                      stretchModes: <StretchMode>[
                        StretchMode.zoomBackground,
                      ],
                      title: Container(
                        padding: EdgeInsets.symmetric(vertical: 22.0 * ratioH),
                        child: LinkedOffsetWidget(
                            originTransitionOffsetY: 0,
                            finalTransitionOffsetY: -60 * ratioH,
                            onOffsetChanged: (double offset) {},
                            scrollController: _scrollController,
                            child: 
                            // Consumer<BookProvider>(
                            //     builder: (context, bookProvider, child) {
                            //   return bookProvider.book.length == 0 &&
                            //           !bookProvider.isLoading
                            //       ? LinearProgressIndicator()
                            //       : bookProvider.isLoading
                            //           ? Shimmer.fromColors(
                            //               child: Container(),
                            //               baseColor: Colors.grey[300]!,
                            //               highlightColor: Colors.grey[100]!)
                            //           : 
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              _page[_tabController.index].item1,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _page[_tabController.index]
                                                        .item2,
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    _page[_tabController.index]
                                                        .item3,
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                            //             );
                            // }
                            )
                            ),
                      ),
                      titlePadding: EdgeInsets.zero,
                    ),
                  ),
                  backgroundColor: ThemeConfig.bgColor,
                  elevation: 3.0,
                  pinned: true,
                  snap: false,
                  primary: true,
                  forceElevated: innerBoxIsScrolled,
                  automaticallyImplyLeading: true,
                  expandedHeight: ratioH * 240,
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
            padding: EdgeInsets.fromLTRB(46 * ratioW, 22 * ratioH, 46, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BuildRank(
                  image: 'assets/images/bxhno3.png',
                  rank: 'assets/icons/top3.png',
                  sizeImage: 35,
                  sizeRaidius: 38,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.pink,
                ),
                BuildRank(
                  image: 'assets/images/bxhno1.png',
                  rank: 'assets/icons/top1.png',
                  sizeImage: 40,
                  sizeRaidius: 45,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.amber,
                ),
                BuildRank(
                  image: 'assets/images/bxhno2.png',
                  rank: 'assets/icons/top2.png',
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
              child: ListView(
                children: [
                  for (int i = 4; i <= 20; i++)
                    BuildBXH(
                      top: i,
                      total: 250 - i - 1,
                    )
                ],
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
            padding:
                EdgeInsets.fromLTRB(46 * ratioW, 22 * ratioH, 46 * ratioW, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BuildRank(
                  image: 'assets/images/bxhno3.png',
                  rank: 'assets/icons/top3.png',
                  sizeImage: 35,
                  sizeRaidius: 38,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.pink,
                ),
                BuildRank(
                  image: 'assets/images/bxhno1.png',
                  rank: 'assets/icons/top1.png',
                  sizeImage: 40,
                  sizeRaidius: 45,
                  name: 'Trúc Lâm',
                  total: 'Điểm fan: 480',
                  color: Colors.amber,
                ),
                BuildRank(
                  image: 'assets/images/bxhno2.png',
                  rank: 'assets/icons/top2.png',
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
              child: ListView(
                children: [
                  for (int i = 4; i <= 20; i++)
                    BuildBXH(
                      top: i,
                      total: 250 - i - 1,
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildBXH extends StatelessWidget {
  final int top;
  final int total;
  BuildBXH({
    Key? key,
    required this.top,
    required this.total,
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
                  top.toString(),
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
            "Điểm Fan: " + total.toString(),
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

class BuildRank extends StatelessWidget {
  final String image;
  final String rank;
  final String name;
  final String total;
  final double sizeRaidius;
  final double sizeImage;
  final Color color;
  const BuildRank({
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
