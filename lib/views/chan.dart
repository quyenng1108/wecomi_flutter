import 'package:flutter/material.dart';
import 'package:wecomi_flutter/views/test.dart';

class Chan extends StatefulWidget {
  const Chan({ Key? key }) : super(key: key);

  @override
  _ChanState createState() => _ChanState();
}
 int _count = 20;
class _ChanState extends State<Chan> {
  ScrollController scrollController = ScrollController();
  @override
  void initState(){
    super.initState();
    scrollController.addListener(() {
      print("chan");
    });
  }
 
  @override
  Widget build(BuildContext context) {
      List<GlobalKey> _key = List.generate(_count, (index) => GlobalKey());

    return Scaffold(
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            _count = _count + 20;
            setState(() {
              print(_key.length);
            });
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () =>{
                          Scrollable.ensureVisible(_key[5].currentContext!)
                        },
                        child: Container(child: Text("me may"),)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _count,
                        itemBuilder: (context, i) => 
                      Column(
                        children: [
                          Container(
                            key: _key[i],
                            height: 100,child: Text(i.toString()),),
                          Image.network(
                            "http://117.103.207.22:8090/media/chapter/HuyenHuyen/ThangCapManhNhat/chapter5a/7.jpg",
                              ),
                        ],
                      ))
                    ],
                  );
                }
              
              ),
          ),
        ),
      ),
    );
  }
}