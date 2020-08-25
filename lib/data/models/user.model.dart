import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/constants.dart';
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

  String insuranceDoc;
  String transportDoc;
  String kbisDoc;
  String identityDoc;
  String bankDoc;

  bool statusInsuranceDoc;
  bool statusTransportDoc;
  bool statusKbisDoc;
  bool statusIdentityDoc;
  bool statusBankDoc;

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
    this.insuranceDoc = '',
    this.transportDoc = '',
    this.kbisDoc = '',
    this.identityDoc = '',
    this.bankDoc = '',
    this.statusInsuranceDoc = false,
    this.statusTransportDoc = false,
    this.statusKbisDoc = false,
    this.statusIdentityDoc = false,
    this.statusBankDoc = false,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.isActivated = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"] ?? '',
        raisonSociale: json["raisonSociale"] ?? '',
        photoUrl: json["photoUrl"],
        address: json["address"],
        iban: json["iban"],
        bic: json["bic"],
        insuranceDoc: json['insuranceDoc'] ?? '',
        transportDoc: json['transportDoc'] ?? '',
        kbisDoc: json['kbisDoc'] ?? '',
        identityDoc: json['identityDoc'] ?? '',
        bankDoc: json['bankDoc'] ?? '',
        statusInsuranceDoc: json['statusInsuranceDoc'] ?? false,
        statusTransportDoc: json['statusTransportDoc'] ?? false,
        statusKbisDoc: json['statusKbisDoc'] ?? false,
        statusIdentityDoc: json['statusIdentityDoc'] ?? false,
        statusBankDoc: json['statusBankDoc'] ?? false,
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
        "insuranceDoc": insuranceDoc,
        "transportDoc": transportDoc,
        "kbisDoc": kbisDoc,
        "identityDoc": identityDoc,
        "bankDoc": bankDoc,
        "statusInsuranceDoc": statusInsuranceDoc,
        "statusTransportDoc": statusTransportDoc,
        "statusKbisDoc": statusKbisDoc,
        "statusIdentityDoc": statusIdentityDoc,
        "statusBankDoc": statusBankDoc,
        "isEmailVerified": isEmailVerified,
        "isPhoneVerified": isPhoneVerified,
        "isActivated": isActivated,
      };

  getDocStatus(DocType type) {
    if (type == DocType.INSURANCE) {
      if (insuranceDoc.isEmpty) {
        return DocStatus.NONE;
      }
      if (statusInsuranceDoc) {
        return DocStatus.CONFIRMED;
      }
      return DocStatus.PENDING;
    }
    
    if (type == DocType.TRANSPORT) {
      if (transportDoc.isEmpty) {
        return DocStatus.NONE;
      }
      if (statusTransportDoc) {
        return DocStatus.CONFIRMED;
      }
      return DocStatus.PENDING;
    }

    if (type == DocType.KBIS) {
      if (kbisDoc.isEmpty) {
        return DocStatus.NONE;
      }
      if (statusKbisDoc) {
        return DocStatus.CONFIRMED;
      }
      return DocStatus.PENDING;
    }

    if (type == DocType.IDENTITY) {
      if (identityDoc.isEmpty) {
        return DocStatus.NONE;
      }
      if (statusIdentityDoc) {
        return DocStatus.CONFIRMED;
      }
      return DocStatus.PENDING;
    }

    if (type == DocType.BANK) {
      if (bankDoc.isEmpty) {
        return DocStatus.NONE;
      }
      if (statusBankDoc) {
        return DocStatus.CONFIRMED;
      }
      return DocStatus.PENDING;
    }
  }

  Future create() async {
    final docSnap = await Global.firestore.collection('users').document(this.uid).get();
    if (docSnap.data == null) {
      return Global.firestore.collection('users').document(this.uid).setData(this.toJson());
    }

    final user = User.fromJson(docSnap.data);
    user.raisonSociale = this.raisonSociale;
    user.phone = this.phone;
    return Global.firestore.collection('users').document(user.uid).setData(user.toJson());
  }

  Future create3rdLogin(BuildContext context) async {
    final docSnap = await Global.firestore.collection('users').document(this.uid).get();
    if (docSnap.data == null) {
      context.read<AuthProvider>().loggedInUser = this;
      await Global.firestore.collection('users').document(this.uid).setData(this.toJson());
      return context.read<AuthProvider>().updateUser(user: this);
    }

    final user = User.fromJson(docSnap.data);
    if (this.photoUrl != null && this.photoUrl.isNotEmpty) {
       user.photoUrl = this.photoUrl;
    }
    if (this.isEmailVerified) {
      user.isEmailVerified = this.isEmailVerified;
    }
    if (this.phone.isNotEmpty) {
      user.phone = this.phone;
    }
    context.read<AuthProvider>().loggedInUser = user;
    await Global.firestore.collection('users').document(user.uid).setData(user.toJson());
    return context.read<AuthProvider>().updateUser(user: user);
  }

  Future save(BuildContext context) async {
    context.read<AuthProvider>().loggedInUser = this;
    await Global.firestore.collection('users').document(this.uid).setData(this.toJson());
    return context.read<AuthProvider>().updateUser(user: this);
  }
}
