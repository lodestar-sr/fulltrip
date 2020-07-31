import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TransactionEnCours extends StatefulWidget {
  TransactionEnCours({Key key}) : super(key: key);

  @override
  _TransactionEnCoursState createState() => _TransactionEnCoursState();
}

class _TransactionEnCoursState extends State<TransactionEnCours> {
  List<Widget> transactionsList() {
    List<Widget> list = [];
    Global.demoData.forEach((element) {
      list.add(GestureDetector(
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGreyColor.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 4,
              )
            ],
          ),
          child: Container(
            height: 115,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/circle.png',
                                  width: 9, height: 9),
                              Container(
                                  width: 9,
                                  child: Dash(
                                    direction: Axis.vertical,
                                    length: 32,
                                    dashLength: 60,
                                    dashColor: AppColors.darkGreyColor,
                                  )),
                              Image.asset('assets/images/triangle.png',
                                  width: 9, height: 9),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              height: 80,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            element['startcity'],
                                            style: AppStyles.blackTextStyle
                                                .copyWith(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              element['startAdd'],
                                              style: AppStyles
                                                  .navbarInactiveTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .mediumGreyColor,
                                                      fontSize: 11),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            element['arrivalcity'],
                                            style: AppStyles.blackTextStyle
                                                .copyWith(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              element['arrivalAdd'],
                                              style: AppStyles
                                                  .navbarInactiveTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .mediumGreyColor,
                                                      fontSize: 11),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    "${element['price']}€",
                                    style: TextStyle(
                                        color: AppColors.darkGreyColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    element['delivery'],
                                    style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    "${element['volume']}m³" ?? "",
                                    style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Text(
                  element['companyname'],
                  style: AppStyles.blackTextStyle
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('transactioninformation');
        },
      ));
    });
    if (list.length == 0) {
      list.add(Container(
        padding: EdgeInsets.only(left: 32, right: 32, top: 48),
        child: Center(
          child: Text(
            'No data Available',
            style: TextStyle(
                color: AppColors.greyColor, fontSize: 14, height: 1.8),
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
                'Transaction en cours',
                style: AppStyles.blackTextStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: GestureDetector(
                          onTap: () => FocusScope.of(context)
                              .requestFocus(new FocusNode()),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          height:
                                              SizeConfig.safeBlockHorizontal *
                                                  172,
                                          child: ListView(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(
                                                left: 4, right: 4, top: 10),
                                            children: transactionsList(),
                                          ),
                                        )
                                      ]))))));
            })));
  }
}
