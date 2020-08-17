import 'dart:convert';

import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {

  User _loggedInUser;

  User get loggedInUser => _loggedInUser;

  set loggedInUser(User user) {
    _loggedInUser = user;
    notifyListeners();
  }

  Future updateUser({String key = 'user', User user}) {
    if (user != null) {
      this._loggedInUser = user;
      String userJson = json.encode(_loggedInUser.toJson());
      notifyListeners();
      return Global.prefs.setString(key, userJson);
    }
    return Global.prefs.setString(key, null);
  }

  User getData({String key = 'user'}) {
    String userJson = Global.prefs.getString(key);
    if (userJson != null) {
      Map userObj = json.decode(userJson);
      _loggedInUser = User.fromJson(userObj);
      notifyListeners();
      return _loggedInUser;
    }
    return null;
  }

  bool isLoggedIn() {
    _loggedInUser = this.getData(key: 'user');
    notifyListeners();
    return _loggedInUser != null;
  }

  int getCompteBadge() {
    int count = 0;
    count += getInfoBadge();
    return count;
  }

  int getInfoBadge() {
    int count = 0;
    count += getCommanditaireBadge();
    count += getPhoneBadge();
    count += getPaymentBadge();
    count += getRaisonBadge();
    count += getDocBadge();
    return count;
  }

  int getCommanditaireBadge() {
    int count = 0;
    if (_loggedInUser.firstName.isEmpty) {
      count ++;
    }
    if (_loggedInUser.lastName.isEmpty) {
      count ++;
    }
    return count;
  }

  int getPhoneBadge() {
    int count = 0;
    if (_loggedInUser.phone.isEmpty) {
      count ++;
    }
    return count;
  }

  int getRaisonBadge() {
    int count = 0;
    if (_loggedInUser.raisonSociale.isEmpty) {
      count ++;
    }
    return count;
  }

  int getPaymentBadge() {
    int count = 0;
    if (_loggedInUser.bic.isEmpty || _loggedInUser.iban.isEmpty) {
      count ++;
    }
    return count;
  }

  int getDocBadge() {
    int count = 0;
    return 4;
  }
}