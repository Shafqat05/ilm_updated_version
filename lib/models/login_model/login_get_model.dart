class LoginGetModel {
  String? status;
  String? authKey;

  LoginGetModel({this.status, this.authKey});

  LoginGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    authKey = json['auth_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['auth_key'] = this.authKey;
    return data;
  }
}