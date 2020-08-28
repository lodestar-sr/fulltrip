import 'package:Fulltrip/screens/profile/transport/completed_lots.dart';
import 'package:Fulltrip/screens/profile/transport/ongoing_lots.dart';
import 'package:Fulltrip/services/lot.service.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Transport extends StatefulWidget {
  Transport({Key key}) : super(key: key);

  @override
  _TransportState createState() => _TransportState();
}

class _TransportState extends State<Transport>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    initData();

    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: Global.transportTabIndex,
    );
    _tabController
        .addListener(() => Global.transportTabIndex = _tabController.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  initData() {
    setState(() => Global.isLoading = true);

    final user = context.read<AuthProvider>().loggedInUser;
    LotService.getReservedLots(user).then((lots) {
      setState(() {
        Global.reservedLots = lots;
        Global.isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          iconTheme: IconThemeData(
            color: AppColors.backButtonColor, //change your color here
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Transport',
            style: AppStyles.blackTextStyle
                .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: AppColors.lightGreyColor,
                      width: 1,
                    ),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  labelStyle: TextStyle(fontSize: 16),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('En cours'),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Terminé'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Container(
                  height: SizeConfig.safeScreenHeight - 116,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      OngoingLots(),
                      CompletedLots(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
