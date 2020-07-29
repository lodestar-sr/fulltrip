import 'package:Fulltrip/data/models/lot.dart';
import 'package:Fulltrip/screens/home/home.dart';
import 'package:Fulltrip/screens/messages/MessagesList.dart';
import 'package:Fulltrip/screens/profil/Profil.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
    MessageScreen(
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
            color: Color(0xFFF6F6F6),
            height: 72,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Left Tab icons
                Expanded(
                  child: MaterialButton(
                    minWidth: 72,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 6, top: 20),
                          child: Icon(Feather.search, color: currentTab == 0 ? AppColors.primaryColor : AppColors.lightGreyColor, size: 18),
                        ),
                        Text('Rechercher', style: currentTab == 0 ? AppStyles.navbarActiveTextStyle : AppStyles.navbarInactiveTextStyle),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    minWidth: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 6, top: 20),
                          child: Icon(Feather.plus_square, color: currentTab == 1 ? AppColors.primaryColor : AppColors.lightGreyColor, size: 18),
                        ),
                        Text('Chercher', style: currentTab == 1 ? AppStyles.navbarActiveTextStyle : AppStyles.navbarInactiveTextStyle),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                  ),
                ),

                Expanded(
                  child: Container(
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
                    child: Container(
                      width: 48,
                      height: 48,
                      margin: EdgeInsets.all(6),
                      decoration: new BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          icon: Icon(Icons.add, size: 32, color: Colors.white),
                          onPressed: () {
                            Global.lotForm = Lot();
                            Navigator.of(context).pushNamed('propose-lot');
                          }),
                    ),
                  ),
                ),

                // Right Tab icons
                Expanded(
                  child: MaterialButton(
                    minWidth: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 6, top: 20),
                          child: Icon(Feather.message_square, color: currentTab == 2 ? AppColors.primaryColor : AppColors.lightGreyColor, size: 18),
                        ),
                        Text('Message', style: currentTab == 2 ? AppStyles.navbarActiveTextStyle : AppStyles.navbarInactiveTextStyle),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        currentTab = 2;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    minWidth: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 6, top: 20),
                          child: Icon(Feather.user, color: currentTab == 3 ? AppColors.primaryColor : AppColors.lightGreyColor, size: 18),
                        ),
                        Text('Profil', style: currentTab == 3 ? AppStyles.navbarActiveTextStyle : AppStyles.navbarInactiveTextStyle),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        currentTab = 3;
                      });
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
