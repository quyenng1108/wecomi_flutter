import 'package:equatable/equatable.dart';

class MangaImage extends Equatable {
  final int bookId;
  final int imgId;
  final String imgUrl;
  const MangaImage({
    required this.bookId,
    required this.imgId,
    required this.imgUrl,
  });

  @override
  List<Object?> get props => [bookId, imgId, imgUrl];

  factory MangaImage.fromJson(Map<String, dynamic> jsonObject) {
    return MangaImage(
        bookId: jsonObject["BookId"],
        imgId: jsonObject["imgId"],
        imgUrl: jsonObject["imgUrl"]);
  }
}
