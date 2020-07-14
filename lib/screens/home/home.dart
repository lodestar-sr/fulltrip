import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/data/models/lot.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> lots = [];
  List<Map> filteredlots = [];

  bool geoLocation = false;
  filteredLots() {
    filteredlots.clear();

    lots.forEach((element) {
      print(Global.filterdata);
      Global.filterdata.forEach((filterelement) {
        //Start Add
        var startadd = element['starting_address'].toString().split(",");
        var startcity = startadd.length >= 2
            ? startadd[startadd.length - 2].trim()
            : startadd[startadd.length - 1].trim();
        print(startcity);
        //Arrival Add
        var arrivaladd = element['arrival_address'].toString().split(",");
        var arrivalcity = arrivaladd.length >= 2
            ? arrivaladd[arrivaladd.length - 2].trim()
            : arrivaladd[arrivaladd.length - 1].trim();

        if (filterelement['type'] == 'start_address') {
          print(filterelement['value']);
          if (startcity == filterelement['value']) {
            var a = false;
            filteredlots.forEach((felement) {
              if (felement['id'] == element['id']) {
                a = true;
              }
            });
            if (!a) filteredlots.add(element);
          }
        }
        if (filterelement['type'] == 'arrival_address') {
          if (arrivalcity == filterelement['value']) {
            var a = false;
            filteredlots.forEach((felement) {
              if (felement['id'] == element['id']) {
                a = true;
              }
            });
            if (!a) filteredlots.add(element);
          }
        }
        if (filterelement['type'] == 'price') {
          if (element['price'] >= filterelement['lowValue'] &&
              element['price'] <= filterelement['highValue']) {
            var a = false;
            filteredlots.forEach((felement) {
              if (felement['id'] == element['id']) {
                a = true;
              }
            });
            if (!a) filteredlots.add(element);
          }
        }
        if (filterelement['type'] == 'volume') {
          if (element['quantity'] == filterelement['value']) {
            var a = false;
            filteredlots.forEach((felement) {
              if (felement['id'] == element['id']) {
                a = true;
              }
            });
            if (!a) filteredlots.add(element);
          }
        }
        if (filterelement['type'] == 'service') {
          if (element['delivery'] == filterelement['value']) {
            var a = false;
            filteredlots.forEach((felement) {
              if (felement['id'] == element['id']) {
                a = true;
              }
            });
            if (!a) filteredlots.add(element);
          }
        }
      });
    });
  }

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
                  image: this.lots[i]['photo'] != ''
                      ? DecorationImage(
                          image: NetworkImage(this.lots[i]['photo']),
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
                                    child: startingaddress.length >= 2
                                        ? Text(
                                            "${startingaddress[startingaddress.length - 2]}",
                                            style: AppStyles.blackTextStyle
                                                .copyWith(fontSize: 11),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            "${startingaddress[startingaddress.length - 1]}",
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
                                    child: arrivaladdress.length >= 2
                                        ? Text(
                                            "${arrivaladdress[arrivaladdress.length - 2]}",
                                            style: AppStyles.blackTextStyle
                                                .copyWith(fontSize: 11),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            "${arrivaladdress[arrivaladdress.length - 1]}",
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
                        "${this.lots[i]['price'].toStringAsFixed(0)}€" ?? "",
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
        onTap: () {
          Navigator.of(context)
              .pushNamed('lot-details', arguments: this.lots[i]);
        },
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

  List<Widget> getFilteredLots() {
    List<Widget> list = [];
    for (int i = 0; i < this.filteredlots.length; i++) {
      var startingaddress =
          this.filteredlots[i]['starting_address'].toString().split(',');
      var arrivaladdress =
          this.filteredlots[i]['arrival_address'].toString().split(',');

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
                  image: this.filteredlots[i]['photo'] != ''
                      ? DecorationImage(
                          image: NetworkImage(this.filteredlots[i]['photo']),
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
                                    child: startingaddress.length >= 2
                                        ? Text(
                                            "${startingaddress[startingaddress.length - 2]}",
                                            style: AppStyles.blackTextStyle
                                                .copyWith(fontSize: 11),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            "${startingaddress[startingaddress.length - 1]}",
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
                                    child: arrivaladdress.length >= 2
                                        ? Text(
                                            "${arrivaladdress[arrivaladdress.length - 2]}",
                                            style: AppStyles.blackTextStyle
                                                .copyWith(fontSize: 11),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            "${arrivaladdress[arrivaladdress.length - 1]}",
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
                      this.filteredlots[i]['company'] ?? "",
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
                        "${this.filteredlots[i]['price'].toString()}€" ?? "",
                        style: TextStyle(
                            color: AppColors.darkGreyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        this.filteredlots[i]['delivery'] ?? "",
                        style:
                            TextStyle(color: AppColors.greyColor, fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        "${this.filteredlots[i]['quantity'].toString()}m³" ??
                            "",
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
        onTap: () => Navigator.of(context)
            .pushNamed('lot-details', arguments: this.filteredlots[i]),
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

    for (int i = 0; i < Global.filterdata.length; i++) {
      bool checkhighvalue = false;
      if (Global.filterdata[i]['type'] == 'price') {
        if (Global.filterdata[i]['highValue'] == 10000.0) {
          checkhighvalue = true;
        }
      }
      Global.filterdata.isNotEmpty
          ? checkhighvalue
              ? list.add(Container())
              : list.add(Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.only(right: 12, left: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.lightGreyColor),
                  ),
                  child: Row(
                    children: <Widget>[
                      Global.filterdata[i]['type'] == 'start_address'
                          ? Container(
                              margin: EdgeInsets.only(right: 8),
                              child: Image.asset(
                                'assets/images/locationDeparture.png',
                                width: 16,
                                height: 16,
                              ),
                            )
                          : Container(),
                      Global.filterdata[i]['type'] == 'arrival_address'
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
                        (Global.filterdata[i]['type'] == 'price'
                                ? "${Global.filterdata[i]['lowValue'].toString()}€ - ${Global.filterdata[i]['highValue'].toString()}€"
                                : Global.filterdata[i]['value'].toString()) +
                            (Global.filterdata[i]['type'] == 'volume'
                                ? "m³"
                                : ""),
                        style: AppStyles.greyTextStyle.copyWith(fontSize: 10),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Icon(Icons.close,
                              size: 12, color: AppColors.redColor),
                        ),
                        onTap: () {
                          setState(() {
                            Global.filterdata.removeAt(i);
                          });
                        },
                      )
                    ],
                  ),
                ))
          : list.add(Container());
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
    setState(() {
      Global.isLoading = true;
    });
    getDataFromFirestore();
  }

  getDataFromFirestore() {
    Global.firestore.collection('lots').getDocuments().then((querySnapshot) {
      setState(() {
        Global.isLoading = false;
      });
      querySnapshot.documents.forEach((element) {
        setState(() {
          lots.add(element.data);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Global.filterdata.isNotEmpty) {
      setState(() {
        filteredLots();
      });
    }

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
                    children: Global.filterdata.isEmpty
                        ? getLots()
                        : getFilteredLots(),
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
