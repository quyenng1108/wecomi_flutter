import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:wecomi_flutter/components/back_button.dart';
import 'package:wecomi_flutter/components/list_item_book.dart';
import 'package:wecomi_flutter/constants/color_const.dart';
import 'package:wecomi_flutter/constants/font_const.dart';
import 'package:wecomi_flutter/view_models/service_view_models/search_provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  final controller = TextEditingController();
  String text = "";
  String? hintText;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var standardSpacing = EdgeInsets.symmetric(horizontal: width * 0.0427);
    // final style = widget.text.isEmpty ? styleHint : styleActive;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) => Column(children: [
                SizedBox(
                  height: height * 0.0098,
                ),
                    Container(
                        height: 40,
                        margin: standardSpacing,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                child: Icon(Icons.arrow_back,
                                    size: width * 0.064, color: darkGrey),
                                onTap: () => Navigator.pop(context)),
                            // CustomBackButton(color: Colors.grey),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Container(
                                // alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff08252B).withOpacity(.1),
                                        blurRadius: 3,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]),
                                padding: const EdgeInsets.only(left: 8),
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  onSubmitted: (_) =>
                                      FocusScope.of(context).unfocus(),
                                  textInputAction: TextInputAction.search,
                                  autocorrect: false,
                                  controller: controller,
                                  decoration: InputDecoration(
                                    icon: Image.asset(
                                      "assets/icons/Search.png",
                                      height: 24,
                                      color: Colors.grey,
                                    ),
                                    // prefixIcon: Image.asset("assets/icons/Search.png", height: 24,),
                                    suffixIcon: controller.text.isNotEmpty ||
                                            controller.text != ''
                                        ? GestureDetector(
                                            child: Icon(Icons.close,
                                                color: darkGrey, size: 24),
                                            onTap: () {
                                              controller.clear();
                                              searchProvider.search("", 1);
                                              searchProvider.clearSearch();
                                              print(searchProvider.key);
                                              // widget.onChanged('');
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                            },
                                          )
                                        : null,
                                    hintText:
                                        " Tên tác phẩm, tác giả, thể loại...",
                                    hintStyle:
                                        regularExtraLightBlackBodyTextStyle.copyWith(height: 1.5),
                                    border: InputBorder.none,
                                    // contentPadding: EdgeInsets.only(bottom: 15, top: 12)
                                  ),
                                  // textAlign: TextAlign.left,
                                  style: regularBodyTextStyle,
                                  onChanged: (String value) {
                                    searchProvider.search(value, 1);
                                    print(searchProvider.key);
                                    // setState(() {
                                    //   text = controller.text;
                                    // });
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                    searchProvider.key == ""
                        ? Center(
                            child: Text("hem co gi"),
                          )
                        : searchProvider.isLoading == true ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ) : searchProvider.searchResult.length == 0
                            ? Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/icons/Nothing.png", width: width * 0.8053,),
                                    SizedBox(
                                      height: height * 0.0296,
                                    ),
                                    Text("Danh sách truyện theo dõi trống", style: largeRegularBodyTextStyle)
                                  ],
                                ))
                            : Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        top: height * 0.0197,
                                        bottom: height * 0.0394,
                                        left: width * 0.0427,
                                        right: width * 0.0427),
                                    itemCount:
                                        searchProvider.searchResult.length,
                                    itemBuilder: (context, index) {
                                      var category;
                                      var secondCategory;
                                      var categoryList;
                                      if (Provider.of<SearchProvider>(context)
                                              .isLoading ==
                                          false) {
                                        categoryList = searchProvider
                                            .searchResult[index].categoryList!
                                            .split(";");
                                        if (categoryList.length > 1) {
                                          category = categoryList[0];
                                          secondCategory = categoryList[1];
                                        }
                                      }
                                      return SearchItems(
                                        searchKeyword:
                                            searchProvider.matchingWords,
                                        source: searchProvider
                                            .searchResult[index].imgUrl,
                                        title: searchProvider
                                            .searchResult[index].bookName,
                                        author: searchProvider
                                            .searchResult[index].authorNick,
                                        rating: searchProvider
                                            .searchResult[index].rating,
                                        chapterNum: searchProvider
                                            .searchResult[index]
                                            .numberOfChapter,
                                        category: categoryList.length > 1
                                            ? Text(
                                                "$category • $secondCategory",
                                                style: smallRegularBodyTextStyle
                                                    .copyWith(
                                                        color: lightBlack),
                                              )
                                            : Text(
                                                "${searchProvider.searchResult[index].categoryList}",
                                                style: smallRegularBodyTextStyle
                                                    .copyWith(
                                                        color: lightBlack)),
                                      );
                                    }),
                              )
                  ])),
        ),
      ),
    );
  }
}

class SearchItems extends StatelessWidget {
  SearchItems(
      {this.source,
      this.title,
      this.category,
      this.author,
      this.rating,
      this.searchKeyword,
      this.chapterNum});
  final String? source;
  final String? title;
  final Widget? category;
  final String? author;
  final String? rating;
  final List<String>? searchKeyword;
  final int? chapterNum;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.0147),
      height: height * 0.1675,
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
      child: Row(
        children: [
          Container(
            width: width * 0.2906,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(8),
            // ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                source!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.032, vertical: height * 0.0099),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        // margin: EdgeInsets.only(top: height * 0.0098),
                        height: 24,
                        child: SubstringHighlight(
                          terms: searchKeyword,
                          text: title!,
                          textStyle: largeMediumBodyTextStyle,
                          overflow: TextOverflow.ellipsis,
                          textStyleHighlight: largeMediumBodyTextStyle.copyWith(
                              color: majorPink),
                        )),
                    SizedBox(
                      height: height * 0.0049,
                    ),
                    Container(
                      height: 18,
                      child: category,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("assets/icons/Author.png", height: 16),
                          SizedBox(width: width * 0.0106),
                          Text(
                            author!,
                            style: smallRegularBodyTextStyle,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.0049,
                    ),
                    Container(
                      height: 18,
                      child: Row(
                        children: [
                          Image.asset("assets/icons/Star.png", height: 16),
                          SizedBox(width: width * 0.0106),
                          Text(rating!,
                              style: smallRegularBodyTextStyle.copyWith(
                                  color: majorPink)),
                          Text(" Sao",
                              style: smallRegularLightBlackBodyTextStyle),
                          SizedBox(width: width * 0.0424),
                          Image.asset("assets/icons/Page.png", height: 16),
                          SizedBox(width: width * 0.0106),
                          Text(chapterNum!.toString(),
                              style: smallRegularBodyTextStyle.copyWith(
                                  color: majorPink)),
                          Text(" Chương",
                              style: smallRegularLightBlackBodyTextStyle),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
