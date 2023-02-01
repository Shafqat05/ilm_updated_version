class SignUpPostModel {
  String? fname;
  String? lname;
  String? email;
  String? password;
  String? phonenumber;

  SignUpPostModel(
      {this.fname, this.lname, this.email, this.password, this.phonenumber});

  SignUpPostModel.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    password = json['password'];
    phonenumber = json['phonenumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phonenumber'] = this.phonenumber;
    return data;
  }
}