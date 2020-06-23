import 'dart:convert';
import 'package:http/http.dart' as http;

class AppService {

  static AppService _appService;

  static AppService getInstance() {
    if (_appService != null) {
      return _appService;
    }

    _appService = new AppService();
    return _appService;
  }
}