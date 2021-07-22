import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomizedBottomNavBarIcon extends StatelessWidget{
  CustomizedBottomNavBarIcon({
    Key? key,
    required this.source,
    @required this.size,
});
  final String source;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Image.asset(
        source,
        height: size,
        width: size,
      )
    );
  }

}