import 'package:flutter/material.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/constants/font.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      _tabController = TabController(length: 3, vsync: this);
      //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
              Container(
                  width: width,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.0098, right: width * 0.0426),
                            child: GestureDetector(
                              child: Container(
                                  height: 29,
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Chỉnh sửa",
                                    style: regularBodyTextStyle.copyWith(
                                        color: Colors.white),
                                  )),
                            ),
                          )),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.0098),
                          child: Container(
                              height: 29,
                              child: Text(
                                "Tủ sách",
                                style: giganticMediumBodyTextStyle.copyWith(
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ),
                    ],
                  )),
              Container(
                height: height * 0.8534,
                margin: EdgeInsets.only(top: height * 0.1466),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned.fill(
                            child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffE9E8F0),
                                width: 2,
                              ),
                            ),
                          ),
                        )),
                        TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(text: "Lịch sử"),
                            Tab(text: "Theo dõi"),
                            Tab(text: "Tải xuống")
                          ],
                          labelColor: Color(0xffF05A77),
                          labelStyle: mediumBodyTextStyle,
                          unselectedLabelStyle: regularBodyTextStyle,
                          unselectedLabelColor: Color(0xff7F7F7F),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Color(0xffF05A77),
                          indicatorWeight: 2,
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(
                          child: Text("chan"),
                        ),
                        Center(
                          child: Text("chan"),
                        ),
                        Center(
                          child: Text("chan"),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
