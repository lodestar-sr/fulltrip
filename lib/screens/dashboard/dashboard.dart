import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;

  Widget currentScreen = Container();

  final List<Widget> screens = [
    Container(),
    Container(),
    Container(),
    Container(),
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
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Left Tab icons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 72,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(margin: EdgeInsets.only(bottom: 8, top: 12), child: currentTab == 0 ? Icon(Feather.home) : Icon(Feather.home)),
                          Text('Home'),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
                        });
                      },
                    ),
                    MaterialButton(
                      minWidth: 72,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(margin: EdgeInsets.only(bottom: 8, top: 12), child: currentTab == 0 ? Icon(Feather.search) : Icon(Feather.search)),
                          Text('Search'),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
                        });
                      },
                    ),
                  ],
                ),
                // Right Tab icons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 72,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 8, top: 12),
                            child: currentTab == 0 ? Icon(Ionicons.ios_chatboxes) : Icon(Icons.search)
                          ),
                          Text('Search'),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
                        });
                      },
                    ),
                    MaterialButton(
                      minWidth: 72,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 8, top: 12),
                            child: currentTab == 0 ? Icon(Icons.search) : Icon(Icons.search)
                          ),
                          Text('Search'),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
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
