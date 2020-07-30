import 'dart:convert';

import 'package:Fulltrip/data/models/user.dart';
import 'package:Fulltrip/util/global.dart';

class AuthService {
  static AuthService _appService;
  User loggedInUser;

  static AuthService getInstance() {
    if (_appService != null) {
      return _appService;
    }

    _appService = new AuthService();
    return _appService;
  }

  Future updateUser({String key = 'user', User user}) {
    if (user != null) {
      this.loggedInUser = user;
      String userJson = json.encode(loggedInUser.toJson());
      return Global.prefs.setString(key, userJson);
    }
    return Global.prefs.setString(key, null);
  }

  User getData({String key = 'user'}) {
    String userJson = Global.prefs.getString(key);
    if (userJson != null) {
      Map userObj = json.decode(userJson);
      loggedInUser = User.fromJson(userObj);
      return loggedInUser;
    }
    return null;
  }

  bool isLoggedIn() {
    loggedInUser = this.getData(key: 'user');
    return loggedInUser != null;
  }
}
