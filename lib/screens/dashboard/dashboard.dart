import 'package:Fulltrip/screens/home/home.dart';
import 'package:Fulltrip/screens/home/propose_lot/propose_lot.dart';
import 'package:Fulltrip/screens/messages/MessagesList.dart';
import 'package:Fulltrip/screens/profil/Profil.dart';
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
    ProposeLot(
      key: PageStorageKey('Page2'),
    ),
    MessageScreen(
      key: PageStorageKey('Page3'),
    ),
    Compte(
      key: PageStorageKey('Page4'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  onTabTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: screens[currentTab],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          onTap: onTabTapped,
          currentIndex: currentTab,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(
                Feather.search,
                color: AppColors.navigationBarInactiveColor,
              ),
              title: Text(
                'Rechercher',
                style: AppStyles.navbarActiveTextStyle,
              ),
              activeIcon: Icon(
                Feather.search,
                color: AppColors.primaryColor,
              ),
            ),
            new BottomNavigationBarItem(
              icon: Icon(
                Feather.plus_square,
                color: AppColors.navigationBarInactiveColor,
              ),
              title: Text(
                'Publier',
                style: AppStyles.navbarActiveTextStyle,
              ),
              activeIcon: Icon(
                Feather.plus_square,
                color: AppColors.primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                'Messages',
                style: AppStyles.navbarActiveTextStyle,
              ),
              activeIcon: new Stack(
                children: <Widget>[
                  Icon(
                    Feather.message_square,
                    color: AppColors.primaryColor,
                  ),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        '1',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              icon: new Stack(
                children: <Widget>[
                  Icon(
                    Feather.message_square,
                    color: AppColors.navigationBarInactiveColor,
                  ),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        '1',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            new BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: AppColors.navigationBarInactiveColor,
              ),
              title: Text(
                'Compte',
                style: AppStyles.navbarActiveTextStyle,
              ),
              activeIcon: Icon(
                Icons.person_outline,
                color: AppColors.primaryColor,
              ),
            ),
          ]),
    );
  }
}
