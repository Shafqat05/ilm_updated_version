class BookChapterGetModel {
  String? status;
  List<Data>? data;

  BookChapterGetModel({this.status, this.data});

  BookChapterGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      if(json['data'] != null){
        json['data'].forEach((v) {
          data!.add(new Data.fromJson(v));
        });
      }
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
  String? bookIsbn;
  String? bookAuthor;
  String? cId;
  String? cNumber;
  String? chapterName;
  String? status;
  dynamic? bookmarked;

  Data(
      {this.bId,
        this.bookName,
        this.bookIsbn,
        this.bookAuthor,
        this.cId,
        this.cNumber,
        this.chapterName,
        this.status,
        this.bookmarked});

  Data.fromJson(Map<String, dynamic> json) {
    bId = json['b_id'];
    bookName = json['book_name'];
    bookIsbn = json['book_isbn'];
    bookAuthor = json['book_author'];
    cId = json['c_id'];
    cNumber = json['c_number'];
    chapterName = json['chapter_name'];
    status = json['status'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['b_id'] = this.bId;
    data['book_name'] = this.bookName;
    data['book_isbn'] = this.bookIsbn;
    data['book_author'] = this.bookAuthor;
    data['c_id'] = this.cId;
    data['c_number'] = this.cNumber;
    data['chapter_name'] = this.chapterName;
    data['status'] = this.status;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}