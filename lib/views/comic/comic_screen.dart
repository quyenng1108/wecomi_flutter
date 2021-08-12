import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ComicScreen extends StatefulWidget {
  @override
  _ComicScreenState createState() => _ComicScreenState();
}

class _ComicScreenState extends State<ComicScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //       onPressed: () => Navigator.pop(context),
      //       icon: Image.asset('assets/icons/Back.png',
      //           width: width * 0.064, height: width * 0.064, fit: BoxFit.fill)),
      //   actions: <Widget>[
      //     IconButton(
      //         onPressed: () => {},
      //         icon: Image.asset('assets/icons/Library.png',
      //             width: width * 0.064,
      //             height: width * 0.064,
      //             fit: BoxFit.fill)),
      //   ],
      // ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    // borderRadius:
                    //     BorderRadius.vertical(bottom: Radius.circular(30.0)),
                    child: Image(
                      image: AssetImage("assets/images/comic-01.png"),
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        color: Colors.white),
                    Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.save),
                            iconSize: 30.0,
                            color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("SINH NHẬT ĐÁNG NHỚ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2)),
                      Row(
                        children: <Widget>[
                          // Icon(
                          //   Icons.local_activity,
                          //   size: 10.0,
                          //   color: Colors.white,
                          // ),
                          SizedBox(width: 5.0),
                          Text("Đang cập nhật",
                              style: TextStyle(color: Colors.white))
                        ],
                      )
                    ]),
              ),
              Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.event, color: Colors.white70, size: 25.0),
                      Text("Thứ 3 & 6", style: TextStyle(color: Colors.white))
                    ],
                  ))
            ],
          ),
          Container(
            // color: Theme.of(context).primaryColor,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  icon: Text('Chi Tiết'),
                ),
                Tab(icon: Text('Chapters')),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: Color(0xffB85985))
                                // color: Color(0xffB85985),
                                ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('4.7',
                                                style: TextStyle(
                                                    color: Color(0xffB85985),
                                                    fontSize: 24.0,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Icon(Icons.star,
                                                color: Colors.yellow)
                                          ],
                                        ),
                                        Text('Đánh giá'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('7.2K',
                                            style: TextStyle(
                                                color: Color(0xffB85985),
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w600)),
                                        Text('Bình luận'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('99.7K',
                                            style: TextStyle(
                                                color: Color(0xffB85985),
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w600)),
                                        Text('Lượt Xem'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('5.8K',
                                            style: TextStyle(
                                                color: Color(0xffB85985),
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w600)),
                                        Text('Theo dõi'),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Center(child: Text('Chapters')),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 50,
                            color: Colors.black.withOpacity(.1),
                          )
                        ]),
                    child: Row(children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(14),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(Icons.send_outlined,
                                color: Color(0xffB85985), size: 25.0),
                            Text('Chia sẻ',
                                style: TextStyle(
                                    color: Color(0xffB85985), fontSize: 24.0)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(14),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(Icons.favorite_border_outlined,
                                color: Color(0xffB85985), size: 25.0),
                            Text('Chia sẻ',
                                style: TextStyle(
                                    color: Color(0xffB85985), fontSize: 24.0)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(14),
                            height: 56,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Color(0xffB85985)),
                            child: Text("Đọc tiếp",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ))),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
