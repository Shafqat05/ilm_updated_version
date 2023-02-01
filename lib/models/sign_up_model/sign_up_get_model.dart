class SignupGetModel {
  SignupGetModel({
    this.status,
    this.message,
    this.otp,
  });

  String? status;
  String? message;
  int? otp;

  factory SignupGetModel.fromJson(Map<String, dynamic> json) =>
      SignupGetModel(
        status: json["status"],
        message: json["message"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "otp": otp,
  };
}
