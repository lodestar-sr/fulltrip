import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/data/models/lot.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> lots = [];
  // List<Map> lots = [
  //   {
  //     'company': 'Nom de la compagnie',
  //     'photo':
  //         'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
  //     'price': 700,
  //     'volume': 53,
  //     'startAddress': 'Paris',
  //     'arrivalAddress': 'Vienne',
  //     'service': 'Luxe',
  //   },
  //   {
  //     'company': 'Nom de la compagnie',
  //     'photo':
  //         'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
  //     'price': 700,
  //     'volume': 53,
  //     'startAddress': 'Paris',
  //     'arrivalAddress': 'Vienne',
  //     'service': 'Luxe',
  //   },
  //   {
  //     'company': 'Nom de la compagnie',
  //     'photo':
  //         'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
  //     'price': 700,
  //     'volume': 53,
  //     'startAddress': 'Paris',
  //     'arrivalAddress': 'Vienne',
  //     'service': 'Luxe',
  //   },
  //   {
  //     'company': 'Nom de la compagnie',
  //     'photo':
  //         'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
  //     'price': 700,
  //     'volume': 53,
  //     'startAddress': 'Paris',
  //     'arrivalAddress': 'Vienne',
  //     'service': 'Luxe',
  //   },
  //   {
  //     'company': 'Nom de la compagnie',
  //     'photo':
  //         'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
  //     'price': 700,
  //     'volume': 53,
  //     'startAddress': 'Paris',
  //     'arrivalAddress': 'Vienne',
  //     'service': 'Luxe',
  //   },
  // ];

  List<Map> filters = [
    {'type': 'start_address', 'value': 'Paris'},
    {'type': 'arrival_address', 'value': 'Vienne'},
    {'type': 'price', 'lowValue': 30, 'highValue': 70},
    {'type': 'volume', 'value': 16},
    {'type': 'service', 'value': 'Luxe'},
  ];

  bool geoLocation = false;

  List<Widget> getLots() {
    List<Widget> list = [];
    for (int i = 0; i < this.lots.length; i++) {
      var startingaddress =
          this.lots[i]['starting_address'].toString().split(',');
      var arrivaladdress =
          this.lots[i]['arrival_address'].toString().split(',');

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
                  image: DecorationImage(
                    image: NetworkImage(this.lots[i]['photo'] ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                height: 96,
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
                              Icon(Entypo.circle,
                                  size: 9, color: AppColors.darkGreyColor),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      "${startingaddress[startingaddress.length - 2]},${startingaddress[startingaddress.length - 1]}" ??
                                          "",
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 11),
                                      overflow: TextOverflow.ellipsis,
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
                                dashLength: 3,
                                dashColor: AppColors.darkGreyColor,
                              )),
                          Row(
                            children: <Widget>[
                              Icon(Entypo.circle,
                                  size: 9, color: AppColors.darkGreyColor),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      "${arrivaladdress[arrivaladdress.length - 2]},${arrivaladdress[arrivaladdress.length - 1]}" ??
                                          "",
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 11),
                                      overflow: TextOverflow.ellipsis,
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
                      this.lots[i]['company'] ?? "",
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
                        "${this.lots[i]['price'].toString()}€" ?? "",
                        style: TextStyle(
                            color: AppColors.darkGreyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        this.lots[i]['delivery'] ?? "",
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        "${this.lots[i]['quantity'].toString()}m³" ?? "",
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
        onTap: () => Navigator.of(context).pushNamed('lot-details'),
      ));
    }

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

    for (int i = 0; i < this.filters.length; i++) {
      list.add(Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(right: 12, left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.lightGreyColor),
        ),
        child: Row(
          children: <Widget>[
            filters[i]['type'] == 'start_address'
                ? Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Image.asset(
                      'assets/images/locationDeparture.png',
                      width: 16,
                      height: 16,
                    ),
                  )
                : Container(),
            filters[i]['type'] == 'arrival_address'
                ? Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Image.asset(
                      'assets/images/locationArrival.png',
                      width: 16,
                      height: 16,
                    ),
                  )
                : Container(),
            Text(
              (filters[i]['type'] == 'price'
                      ? "${filters[i]['lowValue'].toString()}€ - ${filters[i]['highValue'].toString()}€"
                      : filters[i]['value'].toString()) +
                  (filters[i]['type'] == 'volume' ? "m³" : ""),
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12, color: AppColors.redColor),
              ),
              onTap: () => {},
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
  void initState() {
    super.initState();
    getDataFromFirestore();
  }

  getDataFromFirestore() {
    Global.firestore.collection('lots').getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((element) {
        print(element.data);
        setState(() {
          lots.add(element.data);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                            style:
                                AppStyles.greyTextStyle.copyWith(fontSize: 14)),
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
                      label:
                          Text('Autour de moi', style: TextStyle(fontSize: 12)),
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
              Container(
                margin: EdgeInsets.only(bottom: 16),
                height: 24,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: getFilters(),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  children: getLots(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
