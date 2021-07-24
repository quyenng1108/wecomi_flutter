import 'package:flutter/material.dart';

class CategoryBubble extends StatelessWidget{
  CategoryBubble({
    @required this.color,
    @required this.onTap,
    @required this.category,   
    @required this.style,  
  });
  final Color? color;
  final Function()? onTap;
  final String? category;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding:EdgeInsets.only(right: width * 0.0213),
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: color,
                          boxShadow: [
                            BoxShadow(
                            color: Color(0xff08252B).withOpacity(.1),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: Offset(0,1), // changes position of shadow
                          ),
                        ],
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Container(
                          // alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: width * 0.0266),
                          child: Center(
                            child: Text(category! ,textAlign: TextAlign.center, style :style )
                            ),
                          ))
                        ),
                    );
  }

}