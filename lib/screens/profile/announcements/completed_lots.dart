import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CompletedLots extends StatefulWidget {
  CompletedLots({Key key}) : super(key: key);

  @override
  _CompletedLotsState createState() => _CompletedLotsState();
}

class _CompletedLotsState extends State<CompletedLots> {
  var myFormat = DateFormat('d/MM');

  List<Widget> listLotItems() {
    List<Widget> list = [];

    Global.proposedLots.forEach((lot) {
      list.add(
        GestureDetector(
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
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                              MaterialCommunityIcons
                                                  .circle_slice_8,
                                              size: 20,
                                              color: AppColors.primaryColor),
                                          Container(
                                              child: Dash(
                                            direction: Axis.vertical,
                                            length: 43,
                                            dashLength: 6,
                                            dashThickness: 2,
                                            dashColor: AppColors.greyColor,
                                          )),
                                          Icon(Feather.map_pin,
                                              size: 20,
                                              color: AppColors.redColor),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 90,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4, bottom: 5),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        lot.startingCity,
                                                        style: AppStyles
                                                            .blackTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      lot.pickupDateFrom != null
                                                          ? Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 5.0),
                                                              child: Text(
                                                                'du ${myFormat.format(lot.pickupDateFrom)} au ${myFormat.format(lot.pickupDateTo)}',
                                                                style: AppStyles
                                                                    .navbarInactiveTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .mediumGreyColor,
                                                                        fontSize:
                                                                            11),
                                                              ),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4, bottom: 8),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        lot.arrivalCity,
                                                        style: AppStyles
                                                            .blackTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      lot.deliveryDateFrom !=
                                                              null
                                                          ? Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 5.0),
                                                              child: Text(
                                                                'du ${myFormat.format(lot.deliveryDateFrom)} au ${myFormat.format(lot.deliveryDateTo)}',
                                                                style: AppStyles
                                                                    .navbarInactiveTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .mediumGreyColor,
                                                                        fontSize:
                                                                            11),
                                                              ),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Prix de l'expédition",
                        style: AppStyles.blackTextStyle
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Container(
                        child: Text(
                          "${lot.price.toStringAsFixed(0)}€" ?? "",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              'lot-details',
              arguments: {'lot': lot, 'company_name': 'Nom du transporteur'},
            );
          },
        ),
      );
    });

    if (list.length == 0) {
      list.add(Container(
        padding: EdgeInsets.only(top: 48),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
                child: Text(
                  '''Aucune donnée disponible.''',
                  style: TextStyle(
                      color: AppColors.greyColor, fontSize: 14, height: 1.8),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
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
      inAsyncCall: false,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Scaffold(
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: SizeConfig.safeBlockVertical * 79,
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                  left: 4, right: 4, top: 10, bottom: 40),
                              children: listLotItems(),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
