import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class User {
  String uid;
  String email;
  String firstName;
  String lastName;
  String phone;
  String raisonSociale;
  String photoUrl;
  String address;

  String iban;
  String bic;

  bool isEmailVerified;
  bool isPhoneVerified;
  bool isActivated;

  User({
    @required this.uid,
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.raisonSociale = '',
    this.photoUrl = '',
    this.address = '',
    this.iban = '',
    this.bic = '',
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.isActivated = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        raisonSociale: json["raisonSociale"],
        photoUrl: json["photoUrl"],
        address: json["address"],
        iban: json["iban"],
        bic: json["bic"],
        isEmailVerified: json.containsKey('isEmailVerified') ? json["isEmailVerified"] : false,
        isPhoneVerified: json.containsKey('isPhoneVerified') ? json["isPhoneVerified"] : false,
        isActivated: json.containsKey('isActivated') ? json["isActivated"] : false,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "raisonSociale": raisonSociale,
        "photoUrl": photoUrl,
        "address": address,
        "iban": iban,
        "bic": bic,
        "isEmailVerified": isEmailVerified,
        "isPhoneVerified": isPhoneVerified,
        "isActivated": isActivated,
      };

  Future create() {
    return Global.firestore.collection('users').document(this.uid).setData(this.toJson());
  }

  Future save(BuildContext context) async {
    context.read<AuthProvider>().loggedInUser = this;
    await Global.firestore.collection('users').document(this.uid).updateData(this.toJson());
    return context.read<AuthProvider>().updateUser(user: this);
  }
}
