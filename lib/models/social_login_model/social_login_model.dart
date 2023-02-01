class SocialLoginModel {
  String? status;
  String? id;
  String? fname;
  String? lname;
  String? email;
  String? mobile;
  String? avatar;
  Null? address;
  Null? city;
  String? socialType;
  String? socialId;
  String? membershipId;
  Null? memExpire;

  SocialLoginModel(
      {this.status,
        this.id,
        this.fname,
        this.lname,
        this.email,
        this.mobile,
        this.avatar,
        this.address,
        this.city,
        this.socialType,
        this.socialId,
        this.membershipId,
        this.memExpire});

  SocialLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    mobile = json['mobile'];
    avatar = json['avatar'];
    address = json['address'];
    city = json['city'];
    socialType = json['social_type '];
    socialId = json['social_id'];
    membershipId = json['membership_id  '];
    memExpire = json['mem_expire '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['avatar'] = this.avatar;
    data['address'] = this.address;
    data['city'] = this.city;
    data['social_type '] = this.socialType;
    data['social_id'] = this.socialId;
    data['membership_id  '] = this.membershipId;
    data['mem_expire '] = this.memExpire;
    return data;
  }
}
