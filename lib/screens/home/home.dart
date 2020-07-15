import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/data/models/lot.dart';
import 'package:fulltrip/services/lot.service.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Lot> lots = [];
  List<Lot> filteredLots = [];
  var myFormat = DateFormat('d/MM');
  LotService _lotService = LotService.getInstance();
  ScrollController scrollController = new ScrollController();
  bool isVisible = true;
  bool geoLocation = false;

  @override
  void initState() {
    super.initState();
    initData();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible)
          setState(() {
            isVisible = false;
          });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isVisible)
          setState(() {
            isVisible = true;
          });
      }
    });
  }

  initData() {
    setState(() => Global.isLoading = true);
    _lotService.getAllLots().then((value) {
      setState(() => lots = value);
      setState(() => Global.isLoading = false);
    });
  }

  filterLots() {
    filteredLots.clear();
    filteredLots = lots;

    if (Global.filter.startingAddress != '') {
      filteredLots = filteredLots.where((lot) {
        final parts = lot.startingAddress.split(',');
        String startCity = parts[parts.length - 2];

        final fParts = Global.filter.startingAddress.split(',');
        String fStartCity = fParts[fParts.length - 2];

        return startCity == fStartCity;
      }).toList();
    }

    if (Global.filter.arrivalAddress != '') {
      filteredLots = filteredLots.where((lot) {
        final parts = lot.arrivalAddress.split(',');
        String arrivalCity = parts[parts.length - 2];

        final fParts = Global.filter.arrivalAddress.split(',');
        String fArrivalCity = fParts[fParts.length - 2];

        return arrivalCity == fArrivalCity;
      }).toList();
    }

    if (Global.filter.quantity != 0) {
      filteredLots = filteredLots
          .where((lot) => lot.quantity == Global.filter.quantity)
          .toList();
    }

    if (Global.filter.delivery != '') {
      filteredLots = filteredLots
          .where((lot) => lot.delivery == Global.filter.delivery)
          .toList();
    }

    if (Global.filter.lowPrice != 0 || Global.filter.highPrice != 0) {
      filteredLots = filteredLots
          .where((lot) =>
              lot.price >= Global.filter.lowPrice &&
              lot.price <= Global.filter.highPrice)
          .toList();
    }
  }

  List<Widget> listLotItems() {
    List<Widget> list = [];

    filteredLots.forEach((lot) {
      var startingaddress = lot.startingAddress.split(',');
      var arrivaladdress = lot.arrivalAddress.split(',');

      String startCity = '';
      if (startingaddress.length >= 2) {
        startCity =
            startingaddress[startingaddress.length - 2].toString().trim();
      } else {
        startCity = startingaddress[0].toString().trim();
      }

      String arriveCity = '';
      if (arrivaladdress.length >= 2) {
        arriveCity =
            arrivaladdress[arrivaladdress.length - 2].toString().trim();
      } else {
        arriveCity = arrivaladdress[0].toString().trim();
      }

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 88,
                height: 96,
                margin: EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  image: lot.photo != ''
                      ? DecorationImage(
                          image: NetworkImage(lot.photo),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: ExactAssetImage('assets/images/noimage.png'),
                          fit: BoxFit.fitWidth,
                        ),
                ),
              ),
              Expanded(
                  child: Container(
                height: 105,
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
                              Image.asset('assets/images/circle.png',
                                  width: 9, height: 9),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          startCity,
                                          style: AppStyles.blackTextStyle
                                              .copyWith(fontSize: 11),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        lot.pickupDateFrom != null
                                            ? Text(
                                                'du ${myFormat.format(lot.pickupDateFrom)} au ${myFormat.format(lot.pickupDateTo)}',
                                                style: AppStyles
                                                    .navbarInactiveTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mediumGreyColor,
                                                        fontSize: 11),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              width: 9,
                              child: Dash(
                                direction: Axis.vertical,
                                length: 32,
                                dashLength: 32,
                                dashColor: AppColors.darkGreyColor,
                              )),
                          Row(
                            children: <Widget>[
                              Image.asset('assets/images/triangle.png',
                                  width: 9, height: 9),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          arriveCity,
                                          style: AppStyles.blackTextStyle
                                              .copyWith(fontSize: 11),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        lot.deliveryDateFrom != null
                                            ? Text(
                                                'du ${myFormat.format(lot.deliveryDateFrom)} au ${myFormat.format(lot.deliveryDateTo)}',
                                                style: AppStyles
                                                    .navbarInactiveTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mediumGreyColor,
                                                        fontSize: 11),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Raison social",
                      style: AppStyles.blackTextStyle
                          .copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        "${lot.price.toStringAsFixed(0)}€" ?? "",
                        style: TextStyle(
                            color: AppColors.darkGreyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        lot.delivery ?? "",
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        "${lot.quantity.toString()}m³" ?? "",
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed('lot-details', arguments: <String, Lot>{'lot': lot});
        },
      ));
    });

    if (list.length == 0) {
      list.add(Container(
        padding: EdgeInsets.only(left: 32, right: 32, top: 48),
        child: Center(
          child: Text(
            'Désolé, la recherche n\'a donné aucun résultat. Essayez de sélectionner d\'autres filtres.',
            style: TextStyle(
                color: AppColors.greyColor, fontSize: 14, height: 1.8),
            textAlign: TextAlign.center,
          ),
        ),
      ));
    }
    return list;
  }

  List<Widget> getFilters() {
    List<Widget> list = [];

    if (Global.filter.startingAddress != '') {
      var startingaddress = Global.filter.startingAddress.split(',');
      String startCity = '';
      if (startingaddress.length >= 2) {
        startCity = startingaddress[startingaddress.length - 2];
      } else {
        startCity = startingaddress[0];
      }

      list.add(Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(right: 12, left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.lightGreyColor),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Image.asset('assets/images/locationDeparture.png',
                  width: 16, height: 16),
            ),
            Text(
              startCity,
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: AppColors.redColor),
              ),
              onTap: () {
                setState(() => Global.filter.resetStartingAddress());
              },
            )
          ],
        ),
      ));
    }

    if (Global.filter.arrivalAddress != '') {
      var arrivaladdress = Global.filter.arrivalAddress.split(',');
      String arriveCity = '';
      if (arrivaladdress.length >= 2) {
        arriveCity = arrivaladdress[arrivaladdress.length - 2];
      } else {
        arriveCity = arrivaladdress[0];
      }
      list.add(Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(right: 12, left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.lightGreyColor),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Image.asset('assets/images/locationArrival.png',
                  width: 16, height: 16),
            ),
            Text(
              arriveCity,
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: AppColors.redColor),
              ),
              onTap: () {
                setState(() => Global.filter.resetArrivalAddress());
              },
            )
          ],
        ),
      ));
    }

    if (Global.filter.quantity != 0) {
      list.add(Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(right: 12, left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.lightGreyColor),
        ),
        child: Row(
          children: <Widget>[
            Text(
              "${Global.filter.quantity}m³",
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: AppColors.redColor),
              ),
              onTap: () {
                setState(() => Global.filter.resetQuantity());
              },
            )
          ],
        ),
      ));
    }

    if (Global.filter.delivery != '') {
      list.add(Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(right: 12, left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.lightGreyColor),
        ),
        child: Row(
          children: <Widget>[
            Text(
              Global.filter.delivery,
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: AppColors.redColor),
              ),
              onTap: () {
                setState(() => Global.filter.resetDelivery());
              },
            )
          ],
        ),
      ));
    }

    if (Global.filter.lowPrice != 0 || Global.filter.highPrice != 10000) {
      list.add(Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(right: 12, left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.lightGreyColor),
        ),
        child: Row(
          children: <Widget>[
            Text(
              "${Global.filter.lowPrice}€ - ${Global.filter.highPrice}€",
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: AppColors.redColor),
              ),
              onTap: () {
                setState(() => Global.filter.resetPrice());
              },
            )
          ],
        ),
      ));
    }

    return list;
  }

  toggleLocation() {
    setState(() {
      geoLocation = !geoLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() => filterLots());

    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 14),
                        child: OutlineButton.icon(
                          icon: Icon(Octicons.settings,
                              size: 14, color: AppColors.primaryColor),
                          label: Text('Filtres',
                              style: AppStyles.greyTextStyle
                                  .copyWith(fontSize: 14)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('filter'),
                          splashColor: AppColors.lightBlueColor,
                        ),
                      ),
                      RaisedButton.icon(
                        icon: Icon(Entypo.direction, size: 14),
                        label: Text('Autour de moi',
                            style: TextStyle(fontSize: 12)),
                        color: geoLocation
                            ? AppColors.primaryColor
                            : AppColors.lightBlueColor,
                        textColor: Colors.white,
                        onPressed: toggleLocation,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: isVisible ? 30.0 : 0.0,
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: getFilters(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.only(left: 4, right: 4, top: 10),
                    children: listLotItems(),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
