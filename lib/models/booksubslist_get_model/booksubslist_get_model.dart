
class BookSubsListGetModel {
  String? status;
  List<Data>? data;

  BookSubsListGetModel({this.status, this.data});

  BookSubsListGetModel.fromJson(Map<String, dynamic> json) {
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
  String? subId;
  String? subUserid;
  String? subBookid;
  String? subAddedate;
  String? bookName;
  String? bookCoverImage;
  String? bookAuthor;
  String? bookIsbn;

  Data(
      {this.subId,
        this.subUserid,
        this.subBookid,
        this.subAddedate,
        this.bookName,
        this.bookCoverImage,
        this.bookAuthor,
        this.bookIsbn});

  Data.fromJson(Map<String, dynamic> json) {
    subId = json['sub_id'];
    subUserid = json['sub_userid'];
    subBookid = json['sub_bookid'];
    subAddedate = json['sub_addedate'];
    bookName = json['book_name'];
    bookCoverImage = json['book_cover_image'];
    bookAuthor = json['book_author'];
    bookIsbn = json['book_isbn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_id'] = this.subId;
    data['sub_userid'] = this.subUserid;
    data['sub_bookid'] = this.subBookid;
    data['sub_addedate'] = this.subAddedate;
    data['book_name'] = this.bookName;
    data['book_cover_image'] = this.bookCoverImage;
    data['book_author'] = this.bookAuthor;
    data['book_isbn'] = this.bookIsbn;
    return data;
  }
}