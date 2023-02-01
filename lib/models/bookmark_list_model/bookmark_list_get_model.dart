class BookMarkListGetModel {
  String? status;
  List<Data>? data;

  BookMarkListGetModel({this.status, this.data});

  BookMarkListGetModel.fromJson(Map<String, dynamic> json) {
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
  String? boId;
  String? boUserId;
  String? boBId;
  String? boExecId;
  String? boChapId;
  String? boChapternum;
  String? boExecNum;
  String? boQuestionnumber;
  String? boDatetime;
  String? webQid;
  String? bookName;
  String? cNumber;
  String? execNum;
  String? questNum;

  Data(
      {this.boId,
        this.boUserId,
        this.boBId,
        this.boExecId,
        this.boChapId,
        this.boChapternum,
        this.boExecNum,
        this.boQuestionnumber,
        this.boDatetime,
        this.webQid,
        this.bookName,
        this.cNumber,
        this.execNum,
        this.questNum});

  Data.fromJson(Map<String, dynamic> json) {
    boId = json['bo_id'];
    boUserId = json['bo_user_id'];
    boBId = json['bo_b_id'];
    boExecId = json['bo_exec_id'];
    boChapId = json['bo_chap_id'];
    boChapternum = json['bo_chapternum'];
    boExecNum = json['bo_exec_num'];
    boQuestionnumber = json['bo_questionnumber'];
    boDatetime = json['bo_datetime'];
    webQid = json['web_qid'];
    bookName = json['book_name'];
    cNumber = json['c_number'];
    execNum = json['exec_num'];
    questNum = json['quest_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bo_id'] = this.boId;
    data['bo_user_id'] = this.boUserId;
    data['bo_b_id'] = this.boBId;
    data['bo_exec_id'] = this.boExecId;
    data['bo_chap_id'] = this.boChapId;
    data['bo_chapternum'] = this.boChapternum;
    data['bo_exec_num'] = this.boExecNum;
    data['bo_questionnumber'] = this.boQuestionnumber;
    data['bo_datetime'] = this.boDatetime;
    data['web_qid'] = this.webQid;
    data['book_name'] = this.bookName;
    data['c_number'] = this.cNumber;
    data['exec_num'] = this.execNum;
    data['quest_num'] = this.questNum;
    return data;
  }
}