import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/services/lot.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

class Liste extends StatefulWidget {
  Liste({Key key}) : super(key: key);

  @override
  _ListeState createState() => _ListeState();
}

class _ListeState extends State<Liste> {
  List<Lot> lots = [];
  List<Distances> _distanceModel = [];
  List<Lot> filteredLots = [];
  var myFormat = DateFormat('d/MM');
  bool isVisible = false;
  bool checkFilter = true;
  String sotBy = '';
  final Geolocator _geolocator = Geolocator();

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    setState(() => Global.isLoading = true);

    final user = context.read<AuthProvider>().loggedInUser;
    LotService.getSearchLots(user).then((searchLots) {
      setState(() {
        lots = searchLots;
        filteredLots = lots;
        Global.isLoading = false;
      });
    });
  }

  _getCurrentLocation({String sortBy}) async {
    _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      try {
        List<Placemark> newPlace = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
        Placemark placeMark = newPlace[0];
        String name = placeMark.name;
        String administrativeArea = placeMark.administrativeArea;
        String postalCode = placeMark.postalCode;
        String country = placeMark.country;
        String address = "${name}, ${administrativeArea} ${postalCode}, ${country}";
        setState(() {
          print(address);
          filterNearMe(address, sortBy: sortBy);
        });
      } catch (e) {
        print(e);
      }
    }).catchError((e) {
      print(e);
    });
  }

  void filterNearMe(String address, {String sortBy}) {
    //address = 'Louches,France';
    setState(() {
      filteredLots.clear();
      filteredLots = lots;
    });
    setState(() => Global.isLoading = true);
    var futures = filteredLots.map((lot) {
      return Global.calculateDistance(startingAddress: address, arrivalAddress: lot.startingAddress);
    }).toList();

    Future.wait(futures).then((List<Map> dist) {
      setState(() => Global.isLoading = false);
      if (mounted) {
        setState(() {
          filteredLots.clear();
          _distanceModel.clear();
        });
        print(dist.length);
        for (var i = 0; i < dist.length; i++) {
          setState(() {
            _distanceModel.add(Distances(distance: dist[i]['distanceinKm'], count: i));
          });
        }
        print(sortBy);
        sortBy == 'closest' ? _distanceModel.sort((b, a) => (b.distance).compareTo(a.distance)) : _distanceModel.sort((a, b) => (b.distance).compareTo(a.distance));
        for (int i = 0; i < _distanceModel.length; i++) {
          setState(() => filteredLots.add(lots[_distanceModel[i].count]));
        }
      }
    }).catchError((error) => setState(() => Global.isLoading = false));
  }

  filterLots() {
    if (Global.filter.startingAddress != '') {
      filteredLots = filteredLots.where((lot) => lot.startingCity == Global.filter.startingCity).toList();
    }

    if (Global.filter.arrivalAddress != '') {
      filteredLots = filteredLots.where((lot) => lot.arrivalCity == Global.filter.arrivalCity).toList();
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
            Expanded(
              child: Text(
                startCity,
                style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 15, color: isVisible ? AppColors.mediumGreyColor : Colors.white),
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
                child: Icon(Icons.close, size: 15, color: isVisible ? AppColors.mediumGreyColor : Colors.white),
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
                  child: Icon(Icons.close, size: 15, color: isVisible ? AppColors.mediumGreyColor : Colors.white),
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
                  child: Icon(Icons.close, size: 15, color: isVisible ? AppColors.mediumGreyColor : Colors.white),
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
                  child: Icon(Icons.close, size: 15, color: isVisible ? AppColors.mediumGreyColor : Colors.white),
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
                child: Icon(Icons.close, size: 15, color: isVisible ? AppColors.mediumGreyColor : Colors.white),
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
                  child: Icon(Icons.close, size: 15, color: isVisible ? AppColors.mediumGreyColor : Colors.white),
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
    if (list.isEmpty) {
      list.add(Container());
    }

    return list;
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
            padding: const EdgeInsets.only(right: 8.0, bottom: 8),
            child: Container(
              height: 160,
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: AppColors.lightGreyColor.withOpacity(0.24), blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lot.proposedCompanyName,
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
                  ),
                  Divider(
                    color: AppColors.lightestGreyColor,
                    thickness: 1,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 85,
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
                                                            lot.startingCity,
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
                                                            lot.arrivalCity,
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
                          margin: EdgeInsets.only(left: 8, bottom: 6),
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
        Container(
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
              ],
            ),
          ),
        ),
      );
    }
    return list;
  }

  Future<void> actionSheet() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            'Trier par',
            style: TextStyle(color: AppColors.navigationBarInactiveColor),
          ),
          actions: [
            CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    sotBy = 'Au plus proche';
                    Navigator.of(context).pop();
                    _getCurrentLocation(sortBy: 'closest');
                  });
                },
                child: Text(
                  'Au plus proche',
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 14),
                )),
            CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    sotBy = 'Au plus loin';
                    Navigator.of(context).pop();
                    _getCurrentLocation(sortBy: 'farest');
                  });
                },
                child: Text(
                  'Au plus loin',
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 14),
                )),
            CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    sotBy = 'Du plus cher au moins cher';
                    Navigator.of(context).pop();
                    _sortByExpensiveToCheapest();
                  });
                },
                child: Text(
                  'Du plus cher au moins cher',
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 14),
                )),
            CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    sotBy = 'Du moins cher au plus cher';
                    Navigator.of(context).pop();
                    _sortByCheapestToExpensive();
                  });
                },
                child: Text(
                  'Du moins cher au plus cher',
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 14),
                )),
            CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    sotBy = 'Du plus petit au plus gros volume';
                    Navigator.of(context).pop();
                    _sodtBySmallestToLargestQuantity();
                  });
                },
                child: Text(
                  'Du plus petit au plus gros volume',
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 14),
                )),
            CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    sotBy = 'Du plus gros au plus petit volume';
                    Navigator.of(context).pop();
                    _sodtByLargestToSmallestQuantity();
                  });
                },
                child: Text(
                  'Du plus gros au plus petit volume',
                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 14),
                )),
          ],
          cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Annuler',
                style: AppStyles.primaryTextStyle.copyWith(fontSize: 14),
              )),
        );
      },
    );
  }

  void _sodtByLargestToSmallestQuantity() {
    setState(() {
      filteredLots.sort((b, a) => a.quantity.compareTo(b.quantity));
    });
  }

  void _sodtBySmallestToLargestQuantity() {
    setState(() {
      filteredLots.sort((a, b) => a.quantity.compareTo(b.quantity));
    });
  }

  void _sortByCheapestToExpensive() {
    setState(() {
      filteredLots.sort((a, b) => a.price.compareTo(b.price));
    });
  }

  void _sortByExpensiveToCheapest() {
    setState(() {
      filteredLots.sort((b, a) => a.price.compareTo(b.price));
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() => filterLots());
    SizeConfig().init(context);
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.primaryColor,
        progressIndicator: AppLoader(),
        child: Scaffold(body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              actionSheet();
                            },
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text('Tri $sotBy'), Icon(Icons.keyboard_arrow_down)],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 72,
                            padding: EdgeInsets.only(top: 8),
                            child: ListView(
                              shrinkWrap: true,
                              children: listLotItems(),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: SwipeDetector(
                            onSwipeUp: () {
                              setState(() {
                                isVisible ? checkFilter = false : null;
                              });
                            },
                            onSwipeDown: () {
                              setState(() {
                                isVisible ? checkFilter = true : null;
                              });
                            },
                            child: Container(
                              color: AppColors.lightestGreyColor,
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 80,
                                      height: 5,
                                      decoration: BoxDecoration(color: isVisible ? AppColors.lightestGreyColor : AppColors.lightGreyColor, borderRadius: BorderRadius.circular(5)),
                                      child: Text(' '),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      // boxShadow: <BoxShadow>[
                                      //   BoxShadow(
                                      //       color: AppColors.primaryColor
                                      //           .withOpacity(0.24),
                                      //       blurRadius: 16,
                                      //       spreadRadius: 0.2),
                                      // ],
                                    ),
                                    child: ButtonTheme(
                                      minWidth: double.infinity,
                                      height: 45,
                                      child: RaisedButton(
                                        child: Text('Options de recherche', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                        color: AppColors.primaryColor,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.of(context).pushNamed('filter');
                                          setState(() {
                                            Global.initialindex = 0;
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
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      height: checkFilter ? 0 : 100,
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
                          ))
                    ],
                  )));
        })));
  }
}

class Distances {
  final distance;
  final count;

  Distances({this.distance, this.count});
}
