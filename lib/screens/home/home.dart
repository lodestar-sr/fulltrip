import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/util/theme.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> lots = [
    {
      'company': 'Nom de la compagnie',
      'photo': 'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
      'price': 700,
      'volume': 53,
      'startAddress': 'Paris',
      'arrivalAddress': 'Vienne',
      'service': 'Luxe',
    },
    {
      'company': 'Nom de la compagnie',
      'photo': 'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
      'price': 700,
      'volume': 53,
      'startAddress': 'Paris',
      'arrivalAddress': 'Vienne',
      'service': 'Luxe',
    },
    {
      'company': 'Nom de la compagnie',
      'photo': 'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
      'price': 700,
      'volume': 53,
      'startAddress': 'Paris',
      'arrivalAddress': 'Vienne',
      'service': 'Luxe',
    },
    {
      'company': 'Nom de la compagnie',
      'photo': 'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
      'price': 700,
      'volume': 53,
      'startAddress': 'Paris',
      'arrivalAddress': 'Vienne',
      'service': 'Luxe',
    },
    {
      'company': 'Nom de la compagnie',
      'photo': 'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
      'price': 700,
      'volume': 53,
      'startAddress': 'Paris',
      'arrivalAddress': 'Vienne',
      'service': 'Luxe',
    },
  ];

  List<Map> filters = [
    {'type': 'address', 'value': 'Paris'},
    {'type': 'price', 'lowValue': 30, 'highValue': 70},
    {'type': 'volume', 'value': 16},
    {'type': 'service', 'value': 'Luxe'},
  ];

  bool geoLocation = false;

  List<Widget> getLots() {
    List<Widget> list = [];
    for (int i = 0; i < this.lots.length; i++) {
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
                    image: NetworkImage(this.lots[i]['photo']),
                    fit: BoxFit.fitHeight,
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
                                Container(
                                  width: 9,
                                  height: 9,
                                  margin: EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF666666)),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text(
                                  this.lots[i]['startAddress'],
                                  style: AppStyles.blackTextStyle.copyWith(fontSize: 11),
                                )
                              ],
                            ),
                            Container(
                                width: 9,
                                child: Dash(
                                  direction: Axis.vertical,
                                  length: 32,
                                  dashLength: 3,
                                  dashColor: Color(0xFF666666),
                                )),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 9,
                                  height: 9,
                                  margin: EdgeInsets.only(right: 4),
                                  decoration: new BoxDecoration(
                                    border: Border.all(color: Color(0xFF666666)),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text(
                                  this.lots[i]['arrivalAddress'],
                                  style: AppStyles.blackTextStyle.copyWith(fontSize: 11),
                                )
                              ],
                            ),
                          ],
                        )),
                    Text(
                      this.lots[i]['company'],
                      style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.bold),
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
                        "${this.lots[i]['price'].toString()}€",
                        style: TextStyle(color: Color(0xFF666666), fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        this.lots[i]['service'],
                        style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        "${this.lots[i]['volume'].toString()}m³",
                        style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.of(context).pushNamed(''),
      ));
    }

    if (list.length == 0) {
      list.add(Container(
        padding: EdgeInsets.only(left: 32, right: 32),
        child: Center(
          child: Text(
            'Désolé, la recherche n\'a donné aucun résultat. Essayez de sélectionner d\'autres filtres.',
            style: TextStyle(color: AppColors.greyColor, fontSize: 18, height: 1.8),
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
            filters[i]['type'] == 'address'
                ? Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Icon(Entypo.location_pin, size: 12, color: AppColors.lightGreyColor),
                  )
                : Container(),
            Text(
              (filters[i]['type'] == 'price' ? "${filters[i]['lowValue'].toString()}€ - ${filters[i]['highValue'].toString()}€" : filters[i]['value'].toString()) +
                  (filters[i]['type'] == 'volume' ? "m³" : ""),
              style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.close, size: 12),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                        icon: Icon(Octicons.settings, size: 14, color: AppColors.primaryColor),
                        label: Text('Filtres', style: AppStyles.greyTextStyle.copyWith(fontSize: 14)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        onPressed: () => {},
                        splashColor: AppColors.cyanColor,
                      ),
                    ),
                    geoLocation
                        ? RaisedButton.icon(
                            icon: Icon(Entypo.direction, size: 14),
                            label: Text('Autour de moi', style: TextStyle(fontSize: 12)),
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            onPressed: toggleLocation,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        : OutlineButton.icon(
                            icon: Icon(Entypo.direction, size: 14, color: AppColors.greyColor),
                            label: Text('Autour de moi', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            borderSide: BorderSide(color: AppColors.primaryColor),
                            onPressed: toggleLocation,
                            splashColor: AppColors.cyanColor,
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
