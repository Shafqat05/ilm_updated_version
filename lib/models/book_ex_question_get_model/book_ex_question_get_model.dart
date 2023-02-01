class BookExQuesGetModel {
  String? status;
  List<Data>? data;

  BookExQuesGetModel({this.status, this.data});

  BookExQuesGetModel.fromJson(Map<String, dynamic> json) {
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
  String? execId;
  String? execNum;
  String? questInfo;
  String? questImage;
  String? questNumchap;
  String? questNum;
  String? chapId;
  String? bookId;
  int? bookmarked;

  Data(
      {this.execId,
        this.execNum,
        this.questInfo,
        this.questImage,
        this.questNumchap,
        this.questNum,
        this.chapId,
        this.bookId,
        this.bookmarked});

  Data.fromJson(Map<String, dynamic> json) {
    execId = json['exec_id'];
    execNum = json['exec_num'];
    questInfo = json['quest_info'];
    questImage = json['quest_image'];
    questNumchap = json['quest_numchap'];
    questNum = json['quest_num'];
    chapId = json['chap_id'];
    bookId = json['book_id'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exec_id'] = this.execId;
    data['exec_num'] = this.execNum;
    data['quest_info'] = this.questInfo;
    data['quest_image'] = this.questImage;
    data['quest_numchap'] = this.questNumchap;
    data['quest_num'] = this.questNum;
    data['chap_id'] = this.chapId;
    data['book_id'] = this.bookId;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}