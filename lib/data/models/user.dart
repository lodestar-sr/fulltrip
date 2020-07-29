import 'package:meta/meta.dart';

class User {
  String uid;
  String email;
  String photoUrl;
  String displayName;
  String phone;
  bool isEmailVerified;
  bool isPhoneVerified;

  User({
    @required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.phone,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        displayName: json["displayName"],
        phone: json["phone"],
        isEmailVerified: json.containsKey('isEmailVerified') ? json["isEmailVerified"] : false,
        isPhoneVerified: json.containsKey('isPhoneVerified') ? json["isPhoneVerified"] : false,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "displayName": displayName,
        "phone": phone,
        "isEmailVerified": isEmailVerified,
        "isPhoneVerified": isPhoneVerified,
      };
}
