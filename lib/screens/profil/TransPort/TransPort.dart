import 'package:Fulltrip/screens/profil/TransPort/transport_completed.dart';
import 'package:Fulltrip/screens/profil/TransPort/transportIn_progress.dart';
import 'package:Fulltrip/services/lot.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TransPort extends StatefulWidget {
  TransPort({Key key}) : super(key: key);

  @override
  _TransPortState createState() => _TransPortState();
}

class _TransPortState extends State<TransPort> with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  PageController _controller;
  LotService _lotService = LotService.getInstance();

  @override
  void initState() {
    setUpTabs();
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  initData() {
    setState(() => Global.isLoading = true);
    _lotService.getAllLots().then((value) {
      setState(() => Global.transport = value);
      setState(() => Global.isLoading = false);
    });
  }


  setUpTabs() {
    _controller = PageController(
      initialPage: _tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.primaryColor,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              iconTheme: IconThemeData(
                color: AppColors.backButtonColor, //change your color here
              ),
              backgroundColor: Colors.white,
              title: Text(
                "Transport",
                style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 17),
              ),
            ),
            body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: GestureDetector(
                          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF1F1F1),
                                        border: Border(bottom: BorderSide(color: AppColors.lightGreyColor, width: 1), top: BorderSide(color: AppColors.lightGreyColor, width: 1))),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _tabIndex = 0;
                                              _controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            color: _tabIndex == 0 ? AppColors.primaryColor : Colors.transparent,
                                            child: Text(
                                              'En cours',
                                              style: AppStyles.blackTextStyle.copyWith(color: _tabIndex == 0 ? Colors.white : Colors.black),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _tabIndex = 1;
                                              _controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            color: _tabIndex == 1 ? AppColors.primaryColor : Colors.transparent,
                                            child: Text(
                                              'Terminé',
                                              style: AppStyles.blackTextStyle.copyWith(color: _tabIndex == 1 ? Colors.white : Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: SizeConfig.safeBlockVertical * 79,
                                    child: PageView(
                                      controller: _controller,
                                      onPageChanged: (index) {
                                        setState(() {
                                          _tabIndex = index;
                                        });
                                      },
                                      children: [
                                        TransPortInProgress(),
                                        TransPortCompleted(),
                                      ],
                                    ),
                                  )
                                ],
                              )))));
            })));
  }
}
