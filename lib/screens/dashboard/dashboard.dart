import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/screens/home/home.dart';
import 'package:Fulltrip/screens/home/propose_lot/propose_lot.dart';
import 'package:Fulltrip/screens/profile/profile.dart';
import 'package:Fulltrip/screens/search/search.dart';
import 'package:Fulltrip/screens/updates/updates.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      Home(),
      Search(),
      ProposeLot(onBack: resetPage),
      Updates(),
      Profile(),
    ];
  }

  resetPage() {
    setState(() {
      currentTab = 0;
    });
  }

  onTabTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: currentTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Feather.home,
                color: AppColors.navigationBarInactiveColor, size: 24),
            activeIcon:
                Icon(Feather.home, color: AppColors.primaryColor, size: 24),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.search,
                color: AppColors.navigationBarInactiveColor, size: 24),
            activeIcon:
                Icon(Feather.search, color: AppColors.primaryColor, size: 24),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightGreyColor.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Icon(Icons.add, size: 32, color: Colors.white),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            activeIcon: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(width: 32, height: 32),
                Icon(Feather.bell, color: AppColors.primaryColor, size: 24),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    constraints: BoxConstraints(minWidth: 15, minHeight: 15),
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  ),
                )
              ],
            ),
            icon: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(width: 32, height: 32),
                Icon(Feather.bell,
                    color: AppColors.navigationBarInactiveColor, size: 24),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    constraints: BoxConstraints(minWidth: 15, minHeight: 15),
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  ),
                )
              ],
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
              icon: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(width: 32, height: 32),
                  Icon(AntDesign.user,
                      color: AppColors.navigationBarInactiveColor, size: 24),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: context.watch<AuthProvider>().getProfileBadge() > 0
                        ? Container(
                            width: 15,
                            height: 15,
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                '${context.watch<AuthProvider>().getProfileBadge()}',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 9),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              activeIcon: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(width: 32, height: 32),
                  Icon(AntDesign.user, color: AppColors.primaryColor, size: 24),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: context.watch<AuthProvider>().getProfileBadge() > 0
                        ? Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                '${context.watch<AuthProvider>().getProfileBadge()}',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 9),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              title: Container()),
        ],
      ),
    );
  }
}
