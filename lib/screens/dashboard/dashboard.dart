import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/data/models/lot.dart';
import 'package:fulltrip/screens/home/home.dart';
import 'package:fulltrip/screens/profil/Profil.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;

  final List<Widget> screens = [
    Home(
      key: PageStorageKey('Page1'),
    ),
    Container(
      key: PageStorageKey('Page2'),
    ),
    Container(
      key: PageStorageKey('Page3'),
    ),
    Profil(
      key: PageStorageKey('Page4'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: screens[currentTab],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0,
        child: Container(
            height: 72,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Left Tab icons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 64,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 6, top: 20),
                            child: Icon(Feather.home,
                                color: currentTab == 0
                                    ? AppColors.primaryColor
                                    : AppColors.lightGreyColor,
                                size: 18),
                          ),
                          Text('Recherche',
                              style: currentTab == 0
                                  ? AppStyles.navbarActiveTextStyle
                                  : AppStyles.navbarInactiveTextStyle),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
                        });
                      },
                    ),
                    MaterialButton(
                      minWidth: 64,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 6, top: 20),
                            child: Icon(Feather.search,
                                color: currentTab == 1
                                    ? AppColors.primaryColor
                                    : AppColors.lightGreyColor,
                                size: 18),
                          ),
                          Text('Chercher',
                              style: currentTab == 1
                                  ? AppStyles.navbarActiveTextStyle
                                  : AppStyles.navbarInactiveTextStyle),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentTab = 1;
                        });
                      },
                    ),
                  ],
                ),

                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightGreyColor.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.white70, // inkwell color
                        child: Container(
                          width: 48,
                          height: 48,
                          margin: EdgeInsets.all(6),
                          decoration: new BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add, size: 32, color: Colors.white),
                        ),
                        onTap: () {
                          Global.lotForm = Lot();
                          Navigator.of(context).pushNamed('propose-lot');
                        },
                      ),
                    ),
                  ),
                ),

                // Right Tab icons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 64,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 6, top: 20),
                            child: Icon(Feather.message_square,
                                color: currentTab == 2
                                    ? AppColors.primaryColor
                                    : AppColors.lightGreyColor,
                                size: 18),
                          ),
                          Text('Message',
                              style: currentTab == 2
                                  ? AppStyles.navbarActiveTextStyle
                                  : AppStyles.navbarInactiveTextStyle),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentTab = 2;
                        });
                      },
                    ),
                    MaterialButton(
                      minWidth: 64,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 6, top: 20),
                            child: Icon(FontAwesome.user_o,
                                color: currentTab == 3
                                    ? AppColors.primaryColor
                                    : AppColors.lightGreyColor,
                                size: 18),
                          ),
                          Text('Profil',
                              style: currentTab == 3
                                  ? AppStyles.navbarActiveTextStyle
                                  : AppStyles.navbarInactiveTextStyle),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentTab = 3;
                        });
                      },
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
