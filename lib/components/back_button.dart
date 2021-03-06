import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/color_const.dart';

class CustomBackButton extends StatelessWidget {
  CustomBackButton({@required this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 24,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back,
            size: width * 0.064,
            color: color,
          ),
        ),
      ),
    );
  }
}
