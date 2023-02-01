class MySubscriptionModel {
  String? status;
  List<Data>? data;

  MySubscriptionModel({this.status, this.data});

  MySubscriptionModel.fromJson(Map<String, dynamic> json) {
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
