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
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xffF05A77)),
          color: Colors.white,
        ),
        child: TextButton(
          onPressed: onClicked,
          child: Column(
            children: [
              Image.asset(
                image_captions,
                height: 24,
                width: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
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
