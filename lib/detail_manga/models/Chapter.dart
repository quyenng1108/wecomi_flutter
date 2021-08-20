class Chapter {
  final String name_chapter, name, image, date, heart, comment;
  final bool isActive;

  Chapter({
    required this.name_chapter,
    required this.name,
    required this.image,
    required this.date,
    required this.heart,
    required this.comment,
    required this.isActive,
  });
}

List chapterData = [
  Chapter(
    name_chapter: "Chap 1. ",
    name: "Khởi đầu tồi tệ",
    image: "assets/images/chap1.png",
    date: "18/06/2021",
    heart: "90",
    comment: "100",
    isActive: false,
  ),
  Chapter(
    name_chapter: "Chap 2. ",
    name: "Khởi đầu tồi tệ",
    image: "assets/images/chap2.png",
    date: "18/06/2021",
    heart: "90",
    comment: "100",
    isActive: false,
  ),
  Chapter(
    name_chapter: "Chap 3. ",
    name: "Khởi đầu tồi tệ",
    image: "assets/images/chap3.png",
    date: "18/06/2021",
    heart: "90",
    comment: "100",
    isActive: false,
  ),
  Chapter(
    name_chapter: "Chap 4. ",
    name: "Khởi đầu tồi tệ",
    image: "assets/images/chap4.png",
    date: "18/06/2021",
    heart: "90",
    comment: "100",
    isActive: true,
  ),
];
