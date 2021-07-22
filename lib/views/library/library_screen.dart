import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget{

  @override
  _LibraryScreenState createState() => _LibraryScreenState();

}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Library Screen"),
      ),
    );
  }
}