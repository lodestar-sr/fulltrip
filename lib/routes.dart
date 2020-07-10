import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/screens/auth/login.dart';
import 'package:fulltrip/screens/auth/register.dart';
import 'package:fulltrip/screens/auth/verify_sms.dart';
import 'package:fulltrip/screens/dashboard/dashboard.dart';
import 'package:fulltrip/screens/home/filter/filter.dart';
import 'package:fulltrip/screens/home/home.dart';
import 'package:fulltrip/screens/home/lot_details/lot_details.dart';
import 'package:fulltrip/screens/home/propose_lot/propose_lot.dart';
import 'package:fulltrip/screens/splash/splash.dart';
import 'package:fulltrip/util/global.dart';
import 'screens/home/propose_lot/Felicitations.dart';
import 'screens/home/propose_lot/propose_lot3.dart';
import 'screens/home/propose_lot/propose_lot2.dart';
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
    'propose-lot': (BuildContext context) => ProposeLot(),
    'ProposeLot2': (BuildContext context) => ProposeLot2(),
    'ProposeLot3': (BuildContext context) => ProposeLot3(),
    'Felicitations': (BuildContext context) => Felicitations(),
  };

  Routes({FirebaseStorage storage}) {
    Global.storage = storage;
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abonnements',
      theme: appTheme(),
      routes: routes,
      home: Splash(),
    ));
  }
}
