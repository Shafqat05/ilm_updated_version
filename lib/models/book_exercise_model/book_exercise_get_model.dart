class BookExerciseGetModel {
  String? status;
  List<Data>? data;

  BookExerciseGetModel({this.status, this.data});

  BookExerciseGetModel.fromJson(Map<String, dynamic> json) {
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
  String? exercise;
  String? chapId;
  String? questNum;
  String? bookId;
  int? bookmarked;

  Data(
      {this.execId,
        this.execNum,
        this.exercise,
        this.chapId,
        this.questNum,
        this.bookId,
        this.bookmarked});

  Data.fromJson(Map<String, dynamic> json) {
    execId = json['exec_id'];
    execNum = json['exec_num'];
    exercise = json['exercise'];
    chapId = json['chap_id'];
    questNum = json['quest_num'];
    bookId = json['book_id'];
    bookmarked = json['bookmarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exec_id'] = this.execId;
    data['exec_num'] = this.execNum;
    data['exercise'] = this.exercise;
    data['chap_id'] = this.chapId;
    data['quest_num'] = this.questNum;
    data['book_id'] = this.bookId;
    data['bookmarked'] = this.bookmarked;
    return data;
  }
}