import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OngoingLotCard extends StatelessWidget {
  final Lot lot;
  final String status;
  final String companyName;

  OngoingLotCard({this.lot, this.status, this.companyName});

  @override
  Widget build(BuildContext context) {
    var myFormat = DateFormat('d/MM');

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 85,
                    margin: EdgeInsets.only(right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      image: lot.photo != ''
                          ? DecorationImage(
                              image: NetworkImage(lot.photo),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image:
                                  ExactAssetImage('assets/images/noimage.png'),
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                  ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                      CrossAxisAlignment.start,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    lot.pickupDateFrom != null
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.only(
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
                                                      CrossAxisAlignment.start,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    lot.deliveryDateFrom != null
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.only(
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
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        "${lot.quantity.toString()}m³" ?? "",
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Color(0xFFE0E0E0),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status,
                    style: AppStyles.blackTextStyle,
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
          arguments: {'lot': lot, 'company_name': companyName},
        );
      },
    );
  }
}
