class BookSubsPostModel {
  int? bookid;
  String? lng;

  BookSubsPostModel({this.bookid, this.lng});

  BookSubsPostModel.fromJson(Map<String, dynamic> json) {
    bookid = json['bookid'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookid'] = this.bookid;
    data['lng'] = this.lng;
    return data;
  }
}