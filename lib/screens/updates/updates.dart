import 'package:Fulltrip/screens/updates/messages_tab/messages_tab.dart';
import 'package:Fulltrip/screens/updates/notifications_tab/notifications_tab.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';

class Updates extends StatefulWidget {
  Updates({Key key}) : super(key: key);

  @override
  _UpdatesState createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: Global.tabIndex,
    );
    _tabController.addListener(() => Global.tabIndex = _tabController.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appbarColor,
        toolbarHeight: 70,
        bottom: PreferredSize(
          preferredSize: null,
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.inactiveTabTitleColor,
              labelStyle: AppStyles.tabLabelStyle,
              labelPadding: EdgeInsets.only(left: 20),
              indicatorColor: AppColors.primaryColor,
              indicatorPadding: EdgeInsets.only(left: 20),
              tabs: [
                Tab(text: 'Messages'),
                Tab(text: 'Notifications'),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: TabBarView(
          controller: _tabController,
          children: [
            MessagesTab(),
            NotificationsTab(),
          ],
        ),
      ),
    );
  }
}
