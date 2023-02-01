class CommentListModel {
  String? status;
  List<Data>? data;

  CommentListModel({this.status, this.data});

  CommentListModel.fromJson(Map<String, dynamic> json) {
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
  String? cid;
  String? solId;
  String? exceId;
  String? chapId;
  String? bId;
  String? comment;
  String? userId;
  String? cDate;
  String? fname;
  String? lname;

  Data(
      {this.cid,
        this.solId,
        this.exceId,
        this.chapId,
        this.bId,
        this.comment,
        this.userId,
        this.cDate,
        this.fname,
        this.lname});

  Data.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    solId = json['sol_id'];
    exceId = json['exce_id'];
    chapId = json['chap_id'];
    bId = json['b_id'];
    comment = json['comment'];
    userId = json['user_id'];
    cDate = json['c_date'];
    fname = json['fname'];
    lname = json['lname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['sol_id'] = this.solId;
    data['exce_id'] = this.exceId;
    data['chap_id'] = this.chapId;
    data['b_id'] = this.bId;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['c_date'] = this.cDate;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    return data;
  }
}
