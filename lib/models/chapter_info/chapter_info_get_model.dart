class ChapterInfoGetModel {
  String? status;
  String? bId;
  String? bookName;
  String? bookIsbn;
  String? bookAuthor;
  String? cId;
  String? cNumber;
  String? bookCoverImage;
  String? chapterName;
  String? chapterstatus;
  dynamic? bookmarked;

  ChapterInfoGetModel(
      {this.status,
        this.bId,
        this.bookName,
        this.bookIsbn,
        this.bookAuthor,
        this.cId,
        this.cNumber,
        this.bookCoverImage,
        this.chapterName,
        this.chapterstatus,
        this.bookmarked});

  ChapterInfoGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bId = json['b_id'];
    bookName = json['book_name'];
    bookIsbn = json['book_isbn'];
    bookAuthor = json['book_author'];
    cId = json['c_id'];
    cNumber = json['c_number'];
    bookCoverImage = json['book_cover_image'];
    chapterName = json['chapter_name'];
    chapterstatus = json['chapterstatus'];
    bookmarked = json['bookmarked'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['b_id'] = this.bId;
    data['book_name'] = this.bookName;
    data['book_isbn'] = this.bookIsbn;
    data['book_author'] = this.bookAuthor;
    data['c_id'] = this.cId;
    data['c_number'] = this.cNumber;
    data['book_cover_image'] = this.bookCoverImage;
    data['chapter_name'] = this.chapterName;
    data['chapterstatus'] = this.chapterstatus;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}