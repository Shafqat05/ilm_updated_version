class ChapterExGetModel {
  String? status;
  List<Data>? data;

  ChapterExGetModel({this.status, this.data});

  ChapterExGetModel.fromJson(Map<String, dynamic> json) {
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
  String? questNumchap;
  String? questNum;
  String? questInfo;
  String? questImage;
  String? bookName;
  String? chapId;
  String? bookId;
  String? bookmaeked;
  bool? validsub;
  List<Solution>? solution;

  Data(
      {this.execId,
        this.execNum,
        this.questNumchap,
        this.questNum,
        this.questInfo,
        this.questImage,
        this.bookName,
        this.chapId,
        this.bookId,
        this.bookmaeked,
        this.validsub,
        this.solution});

  Data.fromJson(Map<String, dynamic> json) {
    execId = json['exec_id'];
    execNum = json['exec_num'];
    questNumchap = json['quest_numchap'];
    questNum = json['quest_num'];
    questInfo = json['quest_info'];
    questImage = json['quest_image'];
    bookName = json['book_name'];
    chapId = json['chap_id'];
    bookId = json['book_id'];
    bookmaeked = json['bookmaeked'];
    validsub = json['validsub'];
    if (json['solution'] != null) {
      solution = <Solution>[];
      json['solution'].forEach((v) {
        solution!.add(new Solution.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exec_id'] = this.execId;
    data['exec_num'] = this.execNum;
    data['quest_numchap'] = this.questNumchap;
    data['quest_num'] = this.questNum;
    data['quest_info'] = this.questInfo;
    data['quest_image'] = this.questImage;
    data['book_name'] = this.bookName;
    data['chap_id'] = this.chapId;
    data['book_id'] = this.bookId;
    data['bookmaeked'] = this.bookmaeked;
    data['validsub'] = this.validsub;
    if (this.solution != null) {
      data['solution'] = this.solution!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Solution {
  String? solId;
  String? commentcount;
  String? solNum;
  String? solTxt;
  String? solImage;
  String? execId;
  String? chapId;
  String? bookId;
  bool? validsub;

  Solution(
      {this.solId,
        this.commentcount,
        this.solNum,
        this.solTxt,
        this.solImage,
        this.execId,
        this.chapId,
        this.bookId,
        this.validsub});

  Solution.fromJson(Map<String, dynamic> json) {
    solId = json['sol_id'];
    commentcount = json['commentcount'];
    solNum = json['sol_num'];
    solTxt = json['sol_txt'];
    solImage = json['sol_image'];
    execId = json['exec_id'];
    chapId = json['chap_id'];
    bookId = json['book_id'];
    validsub = json['validsub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sol_id'] = this.solId;
    data['commentcount'] = this.commentcount;
    data['sol_num'] = this.solNum;
    data['sol_txt'] = this.solTxt;
    data['sol_image'] = this.solImage;
    data['exec_id'] = this.execId;
    data['chap_id'] = this.chapId;
    data['book_id'] = this.bookId;
    data['validsub'] = this.validsub;
    return data;
  }
}