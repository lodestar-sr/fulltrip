import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/screens/home/home.dart';
import 'package:Fulltrip/screens/home/propose_lot/propose_lot.dart';
import 'package:Fulltrip/screens/profile/profile.dart';
import 'package:Fulltrip/screens/search/search.dart';
import 'package:Fulltrip/screens/updates/updates.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/icon_with_badge.dart';
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
      Global.searchTitle = 'Search for a lot';
    });
  }

  @override
  Widget build(BuildContext context) {
    int updatesBadgeCounter = 0;
    int profileBadgeCounter =
        Provider.of<AuthProvider>(context).getProfileBadgeCounter();

    return Scaffold(
      body: screens[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: currentTab,
        selectedIconTheme: IconThemeData(
          color: AppColors.primaryColor,
          size: 24,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.navigationBarInactiveColor,
          size: 24,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Feather.home),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.search),
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
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: IconWithBadge(
              icon: Feather.bell,
              badgeCounter: updatesBadgeCounter,
            ),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: IconWithBadge(
              icon: AntDesign.user,
              badgeCounter: profileBadgeCounter,
            ),
            title: SizedBox(),
          ),
        ],
      ),
    );
  }
}
