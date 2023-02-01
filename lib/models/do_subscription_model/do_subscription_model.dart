class DoSubscriptionModel {
  String? status;
  String? message;
  Data? data;

  DoSubscriptionModel({this.status, this.message, this.data});

  DoSubscriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? tid;
  String? uid;
  String? mid;
  String? activated;
  String? expire;
  String? recurring;
  String? active;
  String? title;
  String? description;
  String? price;
  String? days;
  String? period;
  String? thumb;

  Data(
      {this.id,
        this.tid,
        this.uid,
        this.mid,
        this.activated,
        this.expire,
        this.recurring,
        this.active,
        this.title,
        this.description,
        this.price,
        this.days,
        this.period,
        this.thumb});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tid = json['tid'];
    uid = json['uid'];
    mid = json['mid'];
    activated = json['activated'];
    expire = json['expire'];
    recurring = json['recurring'];
    active = json['active'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    days = json['days'];
    period = json['period'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tid'] = this.tid;
    data['uid'] = this.uid;
    data['mid'] = this.mid;
    data['activated'] = this.activated;
    data['expire'] = this.expire;
    data['recurring'] = this.recurring;
    data['active'] = this.active;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['days'] = this.days;
    data['period'] = this.period;
    data['thumb'] = this.thumb;
    return data;
  }
}
