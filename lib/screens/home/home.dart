import 'package:Fulltrip/data/models/lot.dart';
import 'package:Fulltrip/services/lot.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/user_current_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  bool checkfilter = false;
  Location location = new Location();
  bool _serviceEnabled;

  @override
  void initState() {
    super.initState();
    initData();
    scrollListner();
  }

  scrollListner() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (isVisible)
          setState(() {
            isVisible = false;
          });
      }
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
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
    if (Global.filter.startingAddress != '') {
      filteredLots = filteredLots.where((lot) {
        final parts = lot.startingAddress.split(',');
        String startCity = parts[parts.length - 2];

        final fParts = Global.filter.startingAddress.split(',');
        String fStartCity = fParts[fParts.length - 2];

        return startCity.trim() == fStartCity.trim();
      }).toList();
    }

    if (Global.filter.arrivalAddress != '') {
      filteredLots = filteredLots.where((lot) {
        final parts = lot.arrivalAddress.split(',');
        String arrivalCity = parts[parts.length - 2];

        final fParts = Global.filter.arrivalAddress.split(',');
        String fArrivalCity = fParts[fParts.length - 2];

        return arrivalCity.trim() == fArrivalCity.trim();
      }).toList();
    }

    if (Global.filter.quantity != 0) {
      filteredLots = filteredLots.where((lot) => lot.quantity <= Global.filter.quantity).toList();
    }

    if (Global.filter.delivery != '') {
      filteredLots = filteredLots.where((lot) => lot.delivery == Global.filter.delivery).toList();
    }

    if (Global.filter.lowPrice != 0 || Global.filter.highPrice != 0) {
      filteredLots = filteredLots.where((lot) => lot.price >= Global.filter.lowPrice && lot.price <= Global.filter.highPrice).toList();
    }

    if (Global.filter.pickUpDate != null) {
      filteredLots = filteredLots.where((lot) {
        if (lot.pickupDateFrom == null || lot.pickupDateTo == null) {
          return false;
        }
        if (Global.filter.pickUpDate.isAfter(lot.pickupDateFrom) && Global.filter.pickUpDate.isBefore(lot.pickupDateTo)) {
          return true;
        }
        return false;
      }).toList();
    }

    if (Global.filter.deliveryDate != null) {
      filteredLots = filteredLots.where((lot) {
        if (lot.deliveryDateFrom == null || lot.deliveryDateTo == null) {
          return false;
        }
        if (Global.filter.deliveryDate.isAfter(lot.deliveryDateFrom) && Global.filter.deliveryDate.isBefore(lot.deliveryDateTo)) {
          return true;
        }
        return false;
      }).toList();
    }
  }

  List<Widget> listLotItems() {
    List<Widget> list = [];

    filteredLots.forEach((lot) {
      var startingaddress = lot.startingAddress.split(',');
      var arrivaladdress = lot.arrivalAddress.split(',');

      String startCity = '';
      if (startingaddress.length >= 2) {
        startCity = startingaddress[startingaddress.length - 2].toString().trim();
      } else {
        startCity = startingaddress[0].toString().trim();
      }

      String arriveCity = '';
      if (arrivaladdress.length >= 2) {
        arriveCity = arrivaladdress[arrivaladdress.length - 2].toString().trim();
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
          child: Column(
            children: [
              Row(
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(MaterialCommunityIcons.circle_slice_8, size: 20, color: AppColors.primaryColor),
                                        Container(
                                            child: Dash(
                                          direction: Axis.vertical,
                                          length: 43,
                                          dashLength: 6,
                                          dashThickness: 2,
                                          dashColor: AppColors.greyColor,
                                        )),
                                        Icon(Feather.map_pin, size: 20, color: AppColors.redColor),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 90,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 4, bottom: 5),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      startCity,
                                                      style: AppStyles.blackTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    lot.pickupDateFrom != null
                                                        ? Padding(
                                                            padding: EdgeInsets.only(top: 5.0),
                                                            child: Text(
                                                              'du ${myFormat.format(lot.pickupDateFrom)} au ${myFormat.format(lot.pickupDateTo)}',
                                                              style: AppStyles.navbarInactiveTextStyle.copyWith(color: AppColors.mediumGreyColor, fontSize: 11),
                                                            ),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 4, bottom: 8),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      arriveCity,
                                                      style: AppStyles.blackTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    lot.deliveryDateFrom != null
                                                        ? Padding(
                                                            padding: EdgeInsets.only(top: 5.0),
                                                            child: Text(
                                                              'du ${myFormat.format(lot.deliveryDateFrom)} au ${myFormat.format(lot.deliveryDateTo)}',
                                                              style: AppStyles.navbarInactiveTextStyle.copyWith(color: AppColors.mediumGreyColor, fontSize: 11),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 6),
                          child: Text(
                            lot.delivery ?? "",
                            style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 6),
                          child: Text(
                            "${lot.quantity.toString()}m³" ?? "",
                            style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColors.greyColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Raison social",
                    style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Container(
                    child: Text(
                      "${lot.price.toStringAsFixed(0)}€" ?? "",
                      style: TextStyle(color: AppColors.primaryColor, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('lot-details', arguments: <String, Lot>{'lot': lot});
        },
      ));
    });

    if (list.length == 0) {
      list.add(Container(
        padding: EdgeInsets.only(top: 48),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/nodata.png',
                height: 163,
                width: 145,
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
                child: Text(
                  'Aucun résultats correspondants ',
                  style: AppStyles.primaryTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
                child: Text(
                  '''Aucun résultat pour vos paramètres de recherche, veuillez changer vos filtres.''',
                  style: TextStyle(color: AppColors.greyColor, fontSize: 14, height: 1.8),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: AppColors.primaryColor.withOpacity(0.24), blurRadius: 16, spreadRadius: 4),
                    ],
                  ),
                  child: ButtonTheme(
                    minWidth: SizeConfig.safeBlockHorizontal * 70,
                    height: 50,
                    child: RaisedButton(
                      child: Text('Modifier les filtres', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      color: AppColors.primaryColor,
                      textColor: Colors.white,
                      onPressed: () => Navigator.of(context).pushNamed('filter'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              )
            ],
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

      list.add(card(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Icon(MaterialCommunityIcons.circle_slice_8, size: 15, color: AppColors.primaryColor),
            ),
            Text(
              startCity,
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: isVisible ? AppColors.redColor : Colors.white),
              ),
              onTap: () {
                setState(() {
                  Global.filter.resetStartingAddress();
                  if (geoLocation) {
                    geoLocation = false;
                  }
                });
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
      list.add(card(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Icon(Feather.map_pin, size: 15, color: AppColors.redColor),
            ),
            Text(
              arriveCity,
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: isVisible ? AppColors.redColor : Colors.white),
              ),
              onTap: () {
                setState(() => Global.filter.resetArrivalAddress());
              },
            )
          ],
        ),
      ));
    }

    if (Global.filter.lowPrice != 0 || Global.filter.highPrice != 10000) {
      list.add(card(
        child: Row(
          children: <Widget>[
            Text(
              "${Global.filter.lowPrice}€ - ${Global.filter.highPrice}€",
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: isVisible ? AppColors.redColor : Colors.white),
              ),
              onTap: () {
                setState(() => Global.filter.resetPrice());
              },
            )
          ],
        ),
      ));
    }

    if (Global.filter.delivery != '') {
      list.add(card(
        child: Row(
          children: <Widget>[
            Text(
              Global.filter.delivery,
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: isVisible ? AppColors.redColor : Colors.white),
              ),
              onTap: () {
                setState(() => Global.filter.resetDelivery());
              },
            )
          ],
        ),
      ));
    }

    if (Global.filter.quantity != 0) {
      list.add(card(
        child: Row(
          children: <Widget>[
            Text(
              "≤${Global.filter.quantity}m³",
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: isVisible ? AppColors.redColor : Colors.white),
              ),
              onTap: () {
                setState(() => Global.filter.resetQuantity());
              },
            )
          ],
        ),
      ));
    }

    if (Global.filter.pickUpDate != null) {
      list.add(card(
        child: Row(
          children: <Widget>[
            Text(
              "D'enlèvement: ${Global.filter.pickUpDate.day}/${Global.filter.pickUpDate.month}",
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: isVisible ? AppColors.redColor : Colors.white),
              ),
              onTap: () {
                setState(() => Global.filter.resetPickUpDate());
              },
            )
          ],
        ),
      ));
    }

    if (Global.filter.deliveryDate != null) {
      list.add(card(
        child: Row(
          children: <Widget>[
            Text(
              "Livraison: ${Global.filter.deliveryDate.day}/${Global.filter.deliveryDate.month}",
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: isVisible ? AppColors.redColor : Colors.white),
              ),
              onTap: () {
                setState(() => Global.filter.resetDelivery());
              },
            )
          ],
        ),
      ));
    }

    list.isEmpty ? checkfilter = true : checkfilter = false;
    return list;
  }

  card({Widget child}) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: child,
    );
  }

  toggleLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        return UserCurrentLocation.checkpermissionstatus();
      }
    } else {
      setState(() => geoLocation = !geoLocation);

      if (geoLocation) {
        setState(() => Global.isLoading = true);
        UserCurrentLocation.getCurrentLocation().then((value) {
          setState(() {
            Global.isLoading = false;
          });
          filterNearMe(Global.address);
        }).catchError((err) {
          setState(() => Global.isLoading = false);
          print(err.message);
        });
      } else {
        setState(() {
          Global.filter.resetStartingAddress();
        });
      }
    }
  }

  filterNearMe(String address) {
    setState(() => Global.isLoading = true);
    var futures = lots.map((lot) {
      return Global.calculateDistance(startingAddress: address, arrivalAddress: lot.startingAddress);
    }).toList();

    Future.wait(futures).then((List<Map> dist) {
      setState(() => Global.isLoading = false);
      if (mounted) {
        setState(() {
          filteredLots.clear();
        });
        for (int i = 0; i < dist.length; i++) {
          if (dist[i]['distanceinKm'] > 0 && dist[i]['distanceinKm'] < 20) {
            setState(() => filteredLots.add(lots[i]));
          }
        }
      }
    }).catchError((error) => setState(() => Global.isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (!geoLocation) {
      setState(() {
        filteredLots.clear();
        filteredLots = lots;
      });
    }
    setState(() => filterLots());

    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 36, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 14),
                        child: OutlineButton.icon(
                          icon: Icon(Octicons.settings, size: 16, color: AppColors.greyColor),
                          label: Text('Filtres', style: AppStyles.greyTextStyle.copyWith(fontSize: 14)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          onPressed: () => Navigator.of(context).pushNamed('filter'),
                          splashColor: AppColors.lightBlueColor,
                        ),
                      ),
                      RaisedButton.icon(
                        icon: Icon(MaterialCommunityIcons.target, size: 18),
                        label: Text('Autour de moi', style: TextStyle(fontSize: 12)),
                        color: geoLocation ? AppColors.primaryColor : AppColors.lightBlueColor,
                        textColor: Colors.white,
                        onPressed: toggleLocation,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
                checkfilter
                    ? Container()
                    : AnimatedContainer(
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
