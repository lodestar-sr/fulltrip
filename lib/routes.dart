import 'package:flutter/material.dart';
import 'package:fulltrip/screens/dashboard/dashboard.dart';
import 'util/theme.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    'home': (BuildContext context) => Dashboard(),
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
