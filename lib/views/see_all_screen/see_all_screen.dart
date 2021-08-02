import 'package:flutter/material.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';

class SeeAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Stack(
              //   children: [
                  // Container(
                  //   height: height * 0.1922,
                  //   width: width,
                  //   decoration: BoxDecoration(
                  //       gradient: RadialGradient(
                  //           colors: [Color(0xffB85985), Color(0xffF05A80)],
                  //           center: Alignment(-.95, -1.35),
                  //           radius: 3.5)),
                  //   // child: SafeArea(
                  //     child:
                       Stack(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: CustomBackButton(
                                color: darkGrey,
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.0098),
                            child: Center(
                              child: Container(
                                  height: height * 0.0296,
                                  child: Text(
                                    "Tài khoản",
                                    style: giganticMediumBodyTextStyle,
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                        ],
                      // ),
                    ),
                  // ),
                // ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
