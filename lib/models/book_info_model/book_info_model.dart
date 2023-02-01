class BookInfoGetModel {
  String? status;
  String? bId;
  String? bookName;
  String? bookIsbn;
  String? bookAuthor;
  String? catId;
  String? bookCoverImage;
  dynamic? bookmarked;

  BookInfoGetModel(
      {this.status,
        this.bId,
        this.bookName,
        this.bookIsbn,
        this.bookAuthor,
        this.catId,
        this.bookCoverImage,
        this.bookmarked});

  BookInfoGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bId = json['b_id'];
    bookName = json['book_name'];
    bookIsbn = json['book_isbn'];
    bookAuthor = json['book_author'];
    catId = json['cat_id'];
    bookCoverImage = json['book_cover_image'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['b_id'] = this.bId;
    data['book_name'] = this.bookName;
    data['book_isbn'] = this.bookIsbn;
    data['book_author'] = this.bookAuthor;
    data['cat_id'] = this.catId;
    data['book_cover_image'] = this.bookCoverImage;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}
