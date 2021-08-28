import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecomi_flutter/common/app_session.dart';
import 'package:wecomi_flutter/components/bottom_nav_bar_icon.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/view_models/service_view_models/comic_provider.dart';
import 'package:wecomi_flutter/view_models/service_view_models/genre_provider.dart';
import 'package:wecomi_flutter/views/account/account_screen.dart';
import 'package:wecomi_flutter/views/discover/discover_screen.dart';
import 'package:wecomi_flutter/views/genre/genre_screen.dart';
import 'package:wecomi_flutter/views/home/home_screen.dart';
import 'package:wecomi_flutter/views/library/library_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

ScrollController homeScrollController = ScrollController();
ScrollController genreScrollController = ScrollController();
List<Widget> _pages = [
  HomeScreen(scrollController: homeScrollController),
  DiscoverScreen(),
  GenreScreen(scrollController: genreScrollController),
  LibraryScreen()
];



class _MainScreenState extends State<MainScreen> {
  @override
void initState(){
  super.initState();
     ComicProvider comicProvider =
          Provider.of<ComicProvider>(context, listen: false);
     GenreProvider genreProvider =
          Provider.of<GenreProvider>(context, listen: false);
      comicProvider.getComicBySex(AppSession().sex).then((value) => genreProvider
          .getCategory(1)
          .then((value) => genreProvider.getBooksByCategory(_index + 1, 9998)));
}
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _index,
          children: _pages,
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0xff18274B).withOpacity(.14),
                    offset: Offset(0, 18),
                    spreadRadius: -4,
                    blurRadius: 88),
                BoxShadow(
                    color: Color(0xff18274B).withOpacity(.12),
                    offset: Offset(0, 8),
                    spreadRadius: -6,
                    blurRadius: 28)
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: BottomNavigationBar(
                selectedLabelStyle: mediumTextStyle,
                unselectedLabelStyle: mediumTextStyle,
                selectedItemColor: Theme.of(context).highlightColor,
                unselectedItemColor: Theme.of(context).highlightColor,
                selectedFontSize: 10.0,
                unselectedFontSize: 10.0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                backgroundColor: Theme.of(context).primaryColor,
                onTap: (index) {
                  if (index == _index && index == 0) {
                    _onTap(index, homeScrollController);
                  } else if (index == _index && index == 2) {
                    _onTap(index, genreScrollController);
                  } else {
                    _onPageChanged(index);
                  }
                },
                currentIndex: _index,
                items: [
                  BottomNavigationBarItem(
                      label: "Trang chủ",
                      icon: CustomizedBottomNavBarIcon(
                          source: _index == 0
                              ? "assets/icons/Home-Selected.png"
                              : "assets/icons/Home.png",
                          size: 24)),
                  BottomNavigationBarItem(
                      label: "Khám phá",
                      icon: CustomizedBottomNavBarIcon(
                          source: _index == 1
                              ? "assets/icons/Discover-Selected.png"
                              : "assets/icons/Discover.png",
                          size: 24)),
                  BottomNavigationBarItem(
                      label: "Thế loại",
                      icon: CustomizedBottomNavBarIcon(
                          source: _index == 2
                              ? "assets/icons/Genre-Selected.png"
                              : "assets/icons/Genre.png",
                          size: 24)),
                  BottomNavigationBarItem(
                      label: "Tủ sách",
                      icon: CustomizedBottomNavBarIcon(
                          source: _index == 3
                              ? "assets/icons/Library-Selected.png"
                              : "assets/icons/Library.png",
                          size: 24)),
                ],
              ),
            )));
  }

  void _onPageChanged(int index) {
    setState(() {
      this._index = index;
    });
  }

  void _onTap(int index, ScrollController scrollController) {
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
