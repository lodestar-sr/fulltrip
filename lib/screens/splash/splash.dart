import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/util/theme.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Container(
          padding: EdgeInsets.fromLTRB(16, 120, 16, 48),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          'Fulltrip',
                          style: TextStyle(color: Colors.white, fontSize: 72, fontWeight: FontWeight.bold, shadows: [
                            BoxShadow(color: AppColors.darkColor.withOpacity(0.4), blurRadius: 4, spreadRadius: 2, offset: Offset(0, 6)),
                          ]),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Text(
                          '1ère plateforme d\'échange de lots créée par des déménageurs pour les déménageurs',
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, shadows: [
                            BoxShadow(color: AppColors.darkColor.withOpacity(0.25), blurRadius: 4, spreadRadius: 4),
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: AppColors.whiteColor.withOpacity(0.3), blurRadius: 16, spreadRadius: 4),
                  ],
                ),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 60,
                  child: RaisedButton(
                    child: Text('Commencer', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    color: Colors.white,
                    textColor: Color(0xFF343434),
                    onPressed: () {
                      Navigator.of(context).pushNamed('login');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
