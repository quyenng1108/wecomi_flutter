import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';

class SignupTextField extends StatelessWidget {
  SignupTextField({
    @required this.hintText,
    this.nextFocus,
    this.onSubmitted,
    @required this.inputAction,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    @required this.onErrorWidget,
    @required this.enabledBorder,
    @required this.focusedBorder,
  });
  final Widget? onErrorWidget;
  final Widget? suffixIcon;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final String? hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputAction? inputAction;
  final Function(String)? onSubmitted;
  final Function()? nextFocus;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: height * 0.0689,
        margin: standardSpacing,
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
        child: TextField(
          cursorColor: buttonColor,
          controller: controller,
          obscureText: obscureText,
          textInputAction: inputAction,
          onSubmitted: onSubmitted,
          onEditingComplete: nextFocus,
          onChanged: onChanged,
          decoration: InputDecoration(
              isDense: true,
              // contentPadding: EdgeInsets.symmetric(vertical: height * 0.0689 /2, horizontal:width * 0.0427 ),
              contentPadding: EdgeInsets.only(
                  top: height * 0.0394,
                  bottom: height * 0.0196,
                  left: width * 0.0427,
                  right: width * 0.0427),
              suffixIcon: suffixIcon,
              focusedBorder: focusedBorder,
              enabledBorder: enabledBorder,
              hintText: hintText,
              hintStyle: regularBodyTextStyle),
        ),
      ),
      SizedBox(
        height: height * 0.0049,
      ),
      onErrorWidget!
    ]);
  }
}
