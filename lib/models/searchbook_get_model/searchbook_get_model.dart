class SearchBookGetModel {
  String? status;
  List<Data>? data;

  SearchBookGetModel({this.status, this.data});

  SearchBookGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? bId;
  String? bookName;
  String? catId;
  String? bookIsbn;
  String? bookAuthor;
  String? bookCoverImage;
  String? bookStatus;

  Data(
      {this.bId,
        this.bookName,
        this.catId,
        this.bookIsbn,
        this.bookAuthor,
        this.bookCoverImage,
        this.bookStatus});

  Data.fromJson(Map<String, dynamic> json) {
    bId = json['b_id'];
    bookName = json['book_name'];
    catId = json['cat_id'];
    bookIsbn = json['book_isbn'];
    bookAuthor = json['book_author'];
    bookCoverImage = json['book_cover_image'];
    bookStatus = json['book_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['b_id'] = this.bId;
    data['book_name'] = this.bookName;
    data['cat_id'] = this.catId;
    data['book_isbn'] = this.bookIsbn;
    data['book_author'] = this.bookAuthor;
    data['book_cover_image'] = this.bookCoverImage;
    data['book_status'] = this.bookStatus;
    return data;
  }
}
