import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecomi_flutter/constants/theme.dart';

class BuildContent extends StatelessWidget {
  final String title_captions;
  final String image_captions;
  final VoidCallback onClicked;
  const BuildContent({
    Key? key,
    required this.title_captions,
    required this.image_captions,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratioW = MediaQuery.of(context).size.width / 375;
    final ratioH = MediaQuery.of(context).size.height / 812;
    return Container(
      child: Container(
        height: 68 * ratioH,
        width: 109 * ratioW,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xffF05A77)),
          color: Colors.white,
        ),
        child: TextButton(
          onPressed: onClicked,
          child: Column(
            children: [
              Image.asset(
                image_captions,
                height: 24 * ratioH,
                width: 24 * ratioW,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8 * ratioH),
                child: Text(
                  title_captions,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: ThemeConfig.colorText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
