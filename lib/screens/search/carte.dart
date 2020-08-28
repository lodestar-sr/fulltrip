import 'dart:async';

import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/screens/home/filter/filter.dart';
import 'package:Fulltrip/services/lot.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

class Carte extends StatefulWidget {
  Carte({Key key}) : super(key: key);

  @override
  _CarteState createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;
  String _mapStyle;

  BitmapDescriptor arrivalLocationIcon;
  BitmapDescriptor deliveryIcon;
  BitmapDescriptor startingLocationIcon;
  Set<Marker> _markers = {};
  LatLng _startingLocationPosition = LatLng(0.0, 0.0);
  LatLng _arrivalLocationPosition = LatLng(0.0, 0.0);
  LatLng _deliveryPosition = LatLng(0.0, 0.0);
  List<Lot> lots = [];
  List<Lot> filteredLots = [];
  var myFormat = DateFormat('d/MM');
  bool isVisible = false;
  bool checkFilter = false;
  PageController controller;
  Color showcolor = AppColors.lightestGreyColor;

  @override
  void initState() {
    super.initState();
    Global.customSearch.isEmpty ? initData() : customData();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/arrivalpin.png')
        .then((onValue) {
      arrivalLocationIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/pin.png')
        .then((onValue) {
      startingLocationIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/delivery.png')
        .then((onValue) {
      deliveryIcon = onValue;
    });
    controller = PageController(initialPage: 0);
  }

  customData() {
    setState(() {
      filteredLots = Global.customSearch;
      _resetMarker(
          filteredLots[0].startingAddress, filteredLots[0].arrivalAddress);
    });
    _getCurrentLocation();
  }

  initData() {
    _getCurrentLocation();
    setState(() => Global.isLoading = true);

    final user = context.read<AuthProvider>().loggedInUser;
    LotService.getSearchLots(user).then((searchLots) {
      setState(() {
        filteredLots = searchLots;
        _resetMarker(
            filteredLots[0].startingAddress, filteredLots[0].arrivalAddress);
        Global.isLoading = false;
      });
    });
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        _deliveryPosition = LatLng(position.latitude, position.longitude);

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _startingLocationPosition, zoom: 9),
          ),
        );
        _markers.add(Marker(
            markerId: MarkerId('arrival'),
            position: _arrivalLocationPosition,
            icon: arrivalLocationIcon));
        _markers.add(Marker(
            markerId: MarkerId('starting'),
            position: _startingLocationPosition,
            icon: startingLocationIcon));
        _markers.add(Marker(
            markerId: MarkerId('delivery'),
            position: _deliveryPosition,
            icon: deliveryIcon));
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _resetMarker(String startingAddress, String arrivalAddress) async {
    List<Placemark> startingplacemark =
        await Geolocator().placemarkFromAddress(startingAddress);
    List<Placemark> arrivalplacemark =
        await Geolocator().placemarkFromAddress(arrivalAddress);
    _arrivalLocationPosition = LatLng(arrivalplacemark[0].position.latitude,
        arrivalplacemark[0].position.longitude);
    _startingLocationPosition = LatLng(startingplacemark[0].position.latitude,
        startingplacemark[0].position.longitude);
    await updateCameraLocation(
        LatLng(startingplacemark[0].position.latitude,
            startingplacemark[0].position.longitude),
        LatLng(arrivalplacemark[0].position.latitude,
            arrivalplacemark[0].position.longitude),
        mapController);

    _updatePosition(
        CameraPosition(
            target: LatLng(startingplacemark[0].position.latitude,
                startingplacemark[0].position.longitude)),
        CameraPosition(
            target: LatLng(arrivalplacemark[0].position.latitude,
                arrivalplacemark[0].position.longitude)));
    setState(() {});
  }

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController mapController,
  ) async {
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 95);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  void _updatePosition(
      CameraPosition _startingposition, CameraPosition _arrivalposition) async {
    //Starting Address Marker
    Marker startingmarker = _markers.firstWhere(
        (p) => p.markerId == MarkerId('starting'),
        orElse: () => null);

    _markers.remove(startingmarker);
    _markers.add(
      Marker(
        markerId: MarkerId('starting'),
        position: LatLng(_startingposition.target.latitude,
            _startingposition.target.longitude),
        draggable: true,
        icon: startingLocationIcon,
      ),
    );
    //Starting Address Marker
    Marker arrivalmarker = _markers.firstWhere(
        (p) => p.markerId == MarkerId('arrival'),
        orElse: () => null);

    _markers.remove(arrivalmarker);
    _markers.add(
      Marker(
        markerId: MarkerId('arrival'),
        position: LatLng(_arrivalposition.target.latitude,
            _arrivalposition.target.longitude),
        draggable: true,
        icon: arrivalLocationIcon,
      ),
    );
    setState(() {});
  }

  filterLots() {
    if (Global.filter.startingAddress != '') {
      filteredLots = filteredLots
          .where((lot) => lot.startingCity == Global.filter.startingCity)
          .toList();
    }

    if (Global.filter.arrivalAddress != '') {
      filteredLots = filteredLots
          .where((lot) => lot.arrivalCity == Global.filter.arrivalCity)
          .toList();
    }

    if (Global.filter.quantity != 0) {
      filteredLots = filteredLots
          .where((lot) => lot.quantity <= Global.filter.quantity)
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

    if (Global.filter.pickUpDate != null) {
      filteredLots = filteredLots.where((lot) {
        if (lot.pickupDateFrom == null || lot.pickupDateTo == null) {
          return false;
        }
        if (Global.filter.pickUpDate.isAfter(lot.pickupDateFrom) &&
            Global.filter.pickUpDate.isBefore(lot.pickupDateTo)) {
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
        if (Global.filter.deliveryDate.isAfter(lot.deliveryDateFrom) &&
            Global.filter.deliveryDate.isBefore(lot.deliveryDateTo)) {
          return true;
        }
        return false;
      }).toList();
    }
    setState(() {});
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
              child: Icon(MaterialCommunityIcons.circle_slice_8,
                  size: 15, color: AppColors.primaryColor),
            ),
            Expanded(
              child: Text(
                startCity,
                style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close,
                    size: 15, color: AppColors.mediumGreyColor),
              ),
              onTap: () {
                setState(() {
                  Global.filter.resetStartingAddress();
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
            Expanded(
              child: Text(
                arriveCity,
                style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close,
                    size: 15, color: AppColors.mediumGreyColor),
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
      list.add(
        card(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "${Global.filter.lowPrice}€ - ${Global.filter.highPrice}€",
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Icon(Icons.close,
                      size: 15, color: AppColors.mediumGreyColor),
                ),
                onTap: () {
                  setState(() => Global.filter.resetPrice());
                },
              )
            ],
          ),
        ),
      );
    }

    if (Global.filter.delivery != '') {
      list.add(
        card(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  Global.filter.delivery,
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Icon(Icons.close,
                      size: 15, color: AppColors.mediumGreyColor),
                ),
                onTap: () {
                  setState(() => Global.filter.resetDelivery());
                },
              )
            ],
          ),
        ),
      );
    }

    if (Global.filter.quantity != 0) {
      list.add(
        card(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "≤${Global.filter.quantity}m³",
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Icon(Icons.close,
                      size: 15, color: AppColors.mediumGreyColor),
                ),
                onTap: () {
                  setState(() => Global.filter.resetQuantity());
                },
              )
            ],
          ),
        ),
      );
    }

    if (Global.filter.pickUpDate != null) {
      list.add(card(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "D'enlèvement: ${Global.filter.pickUpDate.day}/${Global.filter.pickUpDate.month}",
                style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close,
                    size: 15, color: AppColors.mediumGreyColor),
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
      list.add(
        card(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Livraison: ${Global.filter.deliveryDate.day}/${Global.filter.deliveryDate.month}",
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Icon(Icons.close,
                      size: 15, color: AppColors.mediumGreyColor),
                ),
                onTap: () {
                  setState(() => Global.filter.resetDelivery());
                },
              )
            ],
          ),
        ),
      );
    }
    if (mounted)
      setState(() {
        list.isEmpty ? isVisible = false : isVisible = true;
        list.isNotEmpty
            ? showcolor = AppColors.mediumGreyColor
            : showcolor = Colors.transparent;
        setstateAfterDelay();
      });
    if (list.isEmpty) {
      list.add(Container());
    }

    return list;
  }

  void setstateAfterDelay() {
    Timer(Duration(milliseconds: 50), () {
      setState(() {});
    });
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Filter()),
    );
    if (result) {
      setState(() {});
      setState(() {});
    }
  }

  Widget card({Widget child}) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  List<Widget> listLotItems() {
    List<Widget> list = [];

    filteredLots.forEach((lot) {
      list.add(
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 8, bottom: 8),
            child: Container(
              height: 128,
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppColors.lightGreyColor.withOpacity(0.24),
                      blurRadius: 10,
                      spreadRadius: 2),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lot.proposedCompanyName,
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
                  Divider(
                    color: AppColors.lightestGreyColor,
                    thickness: 1,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        lot.photo != ''
                            ? Container(
                                width: 70,
                                height: 70,
                                margin: EdgeInsets.only(right: 14),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: AppColors.lightGreyColor,
                                  image: DecorationImage(
                                    image: NetworkImage(lot.photo),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: AppColors.lightGreyColor,
                                ),
                                margin: EdgeInsets.only(right: 14),
                                child: Container(
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/images/noimage.png'),
                                      fit: BoxFit.fitWidth,
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  color:
                                                      AppColors.primaryColor),
                                              Container(
                                                  child: Dash(
                                                direction: Axis.vertical,
                                                length: 32,
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
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4, bottom: 2),
                                                    child:
                                                        SingleChildScrollView(
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
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          lot.pickupDateFrom !=
                                                                  null
                                                              ? Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 2.0),
                                                                  child: Text(
                                                                    'du ${myFormat.format(lot.pickupDateFrom)} au ${myFormat.format(lot.pickupDateTo)}',
                                                                    style: AppStyles
                                                                        .navbarInactiveTextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.mediumGreyColor,
                                                                            fontSize: 11),
                                                                  ),
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4, bottom: 3),
                                                    child:
                                                        SingleChildScrollView(
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
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          lot.deliveryDateFrom !=
                                                                  null
                                                              ? Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 2.0),
                                                                  child: Text(
                                                                    'du ${myFormat.format(lot.deliveryDateFrom)} au ${myFormat.format(lot.deliveryDateTo)}',
                                                                    style: AppStyles
                                                                        .navbarInactiveTextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.mediumGreyColor,
                                                                            fontSize: 11),
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
                          margin: EdgeInsets.only(left: 8, bottom: 6),
                          child: Text(
                            "${lot.quantity.toString()}m³" ?? "",
                            style: TextStyle(
                                color: AppColors.greyColor, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              'lot-reservation',
              arguments: {'lot': lot},
            );
          },
        ),
      );
    });

    if (list.length == 0) {
      list.add(
        Container(),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    setState(() => filterLots());
    SizeConfig().init(context);
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.primaryColor,
        progressIndicator: AppLoader(),
        child: Scaffold(
            body: Stack(
          children: [
            Container(
              height: SizeConfig.safeBlockVertical * 78,
              width: SizeConfig.screenWidth,
              child: GoogleMap(
                initialCameraPosition: _initialLocation,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  mapController.setMapStyle(_mapStyle);
                },
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SwipeDetector(
                  onSwipeUp: () {
                    setState(() {
                      if (isVisible) {
                        checkFilter = true;
                      }
                    });
                  },
                  onSwipeDown: () {
                    setState(() {
                      checkFilter = false;
                    });
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Container(
                          height: 145,
                          child: PageView(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            children: listLotItems(),
                            onPageChanged: (index) {
                              setState(() {
                                _resetMarker(
                                    filteredLots[index].startingAddress,
                                    filteredLots[index].arrivalAddress);
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        color: AppColors.lightestGreyColor,
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 8),
                                width: 80,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: showcolor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(' '),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: ButtonTheme(
                                minWidth: double.infinity,
                                height: 50,
                                child: RaisedButton(
                                  child: Text('Options de recherche',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  color: AppColors.primaryColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      Global.initialindex = 1;
                                      _navigateAndDisplaySelection(context);
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 0),
                              child: AnimatedContainer(
                                padding: const EdgeInsets.only(left: 16.0),
                                duration: Duration(milliseconds: 200),
                                height: checkFilter ? 100 : 0,
                                child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: 5,
                                  primary: false,
                                  children: getFilters(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        )));
  }
}
