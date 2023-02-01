class PackageListModel {
  String? status;
  List<Data>? data;

  PackageListModel({this.status, this.data});

  PackageListModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  String? price;
  String? days;
  String? period;
  String? recurring;
  String? thumb;
  String? private;
  String? active;

  Data(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.days,
        this.period,
        this.recurring,
        this.thumb,
        this.private,
        this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    days = json['days'];
    period = json['period'];
    recurring = json['recurring'];
    thumb = json['thumb'];
    private = json['private'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['days'] = this.days;
    data['period'] = this.period;
    data['recurring'] = this.recurring;
    data['thumb'] = this.thumb;
    data['private'] = this.private;
    data['active'] = this.active;
    return data;
  }
}
