import 'package:flutter/material.dart';
import 'package:fulltrip/screens/dashboard/dashboard.dart';
import 'package:fulltrip/screens/filter/filter.dart';
import 'package:fulltrip/screens/home/home.dart';
import 'util/theme.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    'dashboard': (BuildContext context) => Dashboard(),
    'home': (BuildContext context) => Home(),
    'filter': (BuildContext context) => Filter(),
  };

  Routes() {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abonnements',
      theme: appTheme(),
      routes: routes,
      home: Dashboard(),
    ));
  }
}
