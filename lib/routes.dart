import 'package:flutter/material.dart';
import 'package:fulltrip/screens/auth/login.dart';
import 'package:fulltrip/screens/auth/register.dart';
import 'package:fulltrip/screens/auth/verify_sms.dart';
import 'package:fulltrip/screens/dashboard/dashboard.dart';
import 'package:fulltrip/screens/filter/filter.dart';
import 'package:fulltrip/screens/home/home.dart';
import 'package:fulltrip/screens/lot_details/lot_details.dart';
import 'package:fulltrip/screens/splash/splash.dart';

import 'util/theme.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    'splash': (BuildContext context) => Splash(),
    'login': (BuildContext context) => Login(),
    'register': (BuildContext context) => Register(),
    'verify-sms': (BuildContext context) => VerifySMS(),
    'dashboard': (BuildContext context) => Dashboard(),
    'home': (BuildContext context) => Home(),
    'filter': (BuildContext context) => Filter(),
    'lot-details': (BuildContext context) => LotDetails(),
  };

  Routes() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abonnements',
      theme: appTheme(),
      routes: routes,
      home: Splash(),
    ));
  }
}
