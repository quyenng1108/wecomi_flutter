import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';

class LoginRelatedButton extends StatelessWidget {
  LoginRelatedButton({
    @required this.label,
    @required this.onPressed
  });
  final String? label;
  final Function()? onPressed;
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                height: height * 0.0591, width: width * 0.9146),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  primary: buttonColor,
                  onPrimary: Color(0xffB85985),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48))),
              child: Text(label!, style: largeWhiteTitleTextStyle),
            ),
          );
  }
}