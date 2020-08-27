import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    getStringValuesSF();
    Future.delayed(Constants.splashAnimationDuration, () async {
      if (context.read<AuthProvider>().isLoggedIn()) {
        await context.read<AuthProvider>().downloadUserData();
        Global.address != ''
          ? Navigator.of(context).pushReplacementNamed('dashboard')
          : Navigator.of(context).pushReplacementNamed('map-street');
      } else {
        Navigator.of(context).pushReplacementNamed('login');
      }
    });

    SharedPreferences.getInstance().then((value) {
      Global.prefs = value;
    });
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('globaladdress');

    if (stringValue != null) {
      Global.address = stringValue;
    }
    return stringValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_animation.gif'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
