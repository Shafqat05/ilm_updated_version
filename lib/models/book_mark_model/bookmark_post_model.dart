class BookMarkPostModel {
  String? bookid;
  String? bookmarkid;
  String? execId;
  String? chapId;
  String? chapternum;
  String? execNum;
  int? questionnumber;
  String? lng;

  BookMarkPostModel(
      {this.bookid,
        this.bookmarkid,
        this.execId,
        this.chapId,
        this.chapternum,
        this.execNum,
        this.questionnumber,
        this.lng});

  BookMarkPostModel.fromJson(Map<String, dynamic> json) {
    bookid = json['bookid'];
    bookmarkid = json['bookmarkid'];
    execId = json['exec_id'];
    chapId = json['chap_id'];
    chapternum = json['chapternum'];
    execNum = json['exec_num'];
    questionnumber = json['questionnumber'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookid'] = this.bookid;
    data['bookmarkid'] = this.bookmarkid;
    data['exec_id'] = this.execId;
    data['chap_id'] = this.chapId;
    data['chapternum'] = this.chapternum;
    data['exec_num'] = this.execNum;
    data['questionnumber'] = this.questionnumber;
    data['lng'] = this.lng;
    return data;
  }
}