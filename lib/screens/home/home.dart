import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/services/lot.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/user_current_location.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Lot> lots = [];
  List<Lot> filteredLots = [];
  var myFormat = DateFormat('d/MM');

  bool isVisible = true;
  bool geoLocation = false;

  Location location = new Location();
  bool _serviceEnabled;
  String currentAddress = '';

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
        Global.isLoading = false;
        toggleLocation();
      });
    });
  }

  List<Widget> listLotItems() {
    List<Widget> list = [];

    filteredLots.forEach((lot) {
      list.add(
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
            child: Container(
              height: 160,
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
                      top: 10,
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
                    thickness: 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5),
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
                                    image: ExactAssetImage(
                                        'assets/images/noimage.png'),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4, bottom: 5),
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
                                                                              top: 5.0),
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
                                                        left: 4, bottom: 8),
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
                                                                              top: 5.0),
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
//                Padding(
//                  padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
//                  child: Text(
//                    'Aucun résultats correspondants ',
//                    style: AppStyles.primaryTextStyle.copyWith(fontWeight: FontWeight.w500),
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
//                  child: Text(
//                    '''Aucun résultat pour vos paramètres de recherche, veuillez changer vos filtres.''',
//                    style: TextStyle(color: AppColors.greyColor, fontSize: 14, height: 1.8),
//                    textAlign: TextAlign.center,
//                  ),
//                ),
              ],
            ),
          ),
        ),
      );
    }
    return list;
  }

  void toggleLocation() {
    if (Global.address != '') {
      setState(() {
        Global.isLoading = false;
        var currentCity = Global.address.split(',');
        currentAddress = currentCity[2];
      });
      filterNearMe(Global.address);
    }
  }

  void newLocation() {
    Navigator.of(context).pushNamed('map-street');
  }

  void filterNearMe(String address) {
    setState(() => Global.isLoading = true);
    var futures = lots.map((lot) {
      return Global.calculateDistance(
          startingAddress: address, arrivalAddress: lot.startingAddress);
    }).toList();

    Future.wait(futures).then((List<Map> dist) {
      setState(() => Global.isLoading = false);
      if (mounted) {
        setState(() {
          filteredLots.clear();
        });
        dist.sort((b, a) => (b['distanceinKm']).compareTo(a['distanceinKm']));
        for (int i = 0; i < dist.length; i++) {
          print(dist[i]['distanceinKm']);
          if (i < 5) {
            setState(() => filteredLots.add(lots[i]));
          }
        }
      }
    }).catchError((error) => setState(() => Global.isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // if (!geoLocation) {
    //   setState(() {
    //     filteredLots.clear();
    //     filteredLots = lots;
    //   });
    // }

    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightestGreyColor,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: RaisedButton.icon(
            icon: Image.asset('assets/images/location.png',
                height: 20, width: 20, color: Colors.white),
            label: Text(currentAddress, style: TextStyle(fontSize: 12)),
            color: AppColors.primaryColor,
            textColor: Colors.white,
            onPressed: newLocation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Proche de vous',
                            style: AppStyles.blackTextStyle.copyWith(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.of(context).pushNamed('closetoyou'),
                            child: Text(
                              'Voir plus',
                              style: AppStyles.primaryTextStyle.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: listLotItems(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mis en avant',
                          style: AppStyles.blackTextStyle.copyWith(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('closetoyou'),
                          child: Text(
                            'Voir plus',
                            style: AppStyles.primaryTextStyle.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: listLotItems(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nouveau',
                          style: AppStyles.blackTextStyle.copyWith(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('closetoyou'),
                          child: Text(
                            'Voir plus',
                            style: AppStyles.primaryTextStyle.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: listLotItems(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
