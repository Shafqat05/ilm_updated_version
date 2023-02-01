class BookMarkGetModel {
  String? status;
  String? message;
  int? code;
  int? bid;

  BookMarkGetModel({this.status, this.message, this.code, this.bid});

  BookMarkGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    bid = json['bid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['code'] = this.code;
    data['bid'] = this.bid;
    return data;
  }
}
