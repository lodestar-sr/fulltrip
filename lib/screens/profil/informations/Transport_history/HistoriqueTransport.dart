import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HistoriqueInformation extends StatefulWidget {
  HistoriqueInformation({Key key}) : super(key: key);

  @override
  _HistoriqueInformationState createState() => _HistoriqueInformationState();
}

class _HistoriqueInformationState extends State<HistoriqueInformation> {
  List<Widget> transactionHistory() {
    List<Widget> list = [];
    Global.transportHistory.forEach((element) {
      list.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('detailsduvage');
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 8, top: 8.0),
          height: 95,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/check.png',
                  height: 24,
                  width: 24,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          element['date'],
                          style: AppStyles.navbarInactiveTextStyle.copyWith(color: AppColors.mediumGreyColor),
                        ),
                        Container(
                          height: 43,
                          child: Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('assets/images/circle.png', width: 9, height: 9),
                                  Container(
                                      width: 9,
                                      child: Dash(
                                        direction: Axis.vertical,
                                        length: 32,
                                        dashLength: 25,
                                        dashColor: AppColors.lightGreyColor,
                                      )),
                                  Image.asset('assets/images/triangle.png', width: 9, height: 9),
                                ],
                              ),
                              Container(
                                height: 40,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              element['startcity'],
                                              style: AppStyles.blackTextStyle.copyWith(
                                                fontSize: 11,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              element['arrivalcity'],
                                              style: AppStyles.blackTextStyle.copyWith(
                                                fontSize: 11,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '${element['price']}€',
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ));
    });
    if (list.length == 0) {
      list.add(Container(
        padding: EdgeInsets.only(left: 32, right: 32, top: 48),
        child: Center(
          child: Text(
            'No data Available',
            style: TextStyle(color: AppColors.greyColor, fontSize: 14, height: 1.8),
            textAlign: TextAlign.center,
          ),
        ),
      ));
    }
    return list;
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
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: AppColors.backButtonColor, //change your color here
              ),
              title: Text(
                'Historique de transport',
                style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  width: double.infinity,
                  child: GestureDetector(
                      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                      child: Container(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 40),
                          child: Column(children: [
                            Container(
                              height: SizeConfig.safeBlockHorizontal * 172,
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(left: 4, right: 4, top: 10),
                                children: transactionHistory(),
                              ),
                            )
                          ])))),
            )));
  }
}
