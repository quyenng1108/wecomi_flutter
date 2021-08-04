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
      body: Column(
        children: [
          Stack(
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
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: CustomBackButton(
                          color: Colors.white,
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.0098),
                        child: Container(
                            height: 28,
                            child: Text(
                              "Đề xuất",
                              style: giganticMediumBodyTextStyle.copyWith(
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.8534,
                margin: EdgeInsets.only(top: height * 0.1466),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.0049, horizontal: width * 0.0426),
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(top: height * 0.0147),
                          height: height * 0.1675,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff08252B).withOpacity(.1),
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ]),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.2906,
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(8),
                                // ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    "assets/images/Hot3.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.032,
                                    vertical: height * 0.0098),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 24,
                                            child: Text(
                                              "Tình yêu bá đạo của ác ma",
                                              style: largeMediumBodyTextStyle,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Container(
                                          height: 18,
                                          child: Text("Tình yêu • Tổng tài",
                                              style:
                                                  smallRegularLightBlackBodyTextStyle),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 18,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.asset("assets/icons/Author.png", height: 16),
                                              SizedBox(width: width * 0.0106),
                                              Text("YooLook Culture", style: smallRegularBodyTextStyle,)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.0049,
                                        ),
                                        Container(
                                          height: 18,
                                          child: Row(
                                            children: [
                                              Image.asset("assets/icons/Star.png", height: 16),
                                              SizedBox(width: width * 0.0106),
                                              Text("4.4", style: smallRegularBodyTextStyle.copyWith(color: majorPink)),
                                              Text(" Sao", style: smallRegularLightBlackBodyTextStyle),
                                              SizedBox(width: width * 0.0424),
                                              Image.asset("assets/icons/Page.png", height: 16),
                                              SizedBox(width: width * 0.0106),
                                              Text("82", style: smallRegularBodyTextStyle.copyWith(color: majorPink)),
                                              Text(" Chương", style: smallRegularLightBlackBodyTextStyle),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        )),
              ),
            ],
            // ),
          ),
          // ),
          // ],
          // ),
        ],
      ),
    );
  }
}
