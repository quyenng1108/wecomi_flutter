
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
  
  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
  }
}