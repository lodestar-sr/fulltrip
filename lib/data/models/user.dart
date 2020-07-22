import 'package:meta/meta.dart';

class User {
  String uid;
  String email;
  String photoUrl;
  String displayName;
  String phone;
  bool isEmailVerified;

  User({
    @required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.phone,
    this.isEmailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        displayName: json["displayName"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "displayName": displayName,
        "phone": phone,
      };
}
