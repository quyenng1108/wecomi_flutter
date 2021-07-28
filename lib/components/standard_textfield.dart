import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';

class StandardTextField extends StatelessWidget {
  StandardTextField(
      {@required this.hintText,
      this.errorText,
      this.nextFocus,
      this.onSubmitted,
      @required this.inputAction,
      this.suffixIcon,
      this.obscureText = false,
      @required this.controller,
      this.error,
      this.onChanged});
  final String? hintText;
  final String? errorText;
  final Function()? nextFocus;
  final TextInputAction? inputAction;
  final Function(String)? onSubmitted;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? error;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    return Container(
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
        // focusNode: _passwordFocusNode,
        onEditingComplete: nextFocus,
        onChanged: onChanged,
        decoration: InputDecoration(
            contentPadding: standardSpacing,
            errorText: error,
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffF4E5EC), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffF23053), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffF23053), width: 1),
            ),
            hintText: hintText,
            hintStyle: regularBodyTextStyle),
      ),
    );
  }
}
