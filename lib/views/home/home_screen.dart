import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool positive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 100,
            width: 500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
                Image.asset(
                  "assets/icons/Logo.png",
                  height: 18,
                  width: 90,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
