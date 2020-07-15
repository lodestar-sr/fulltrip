import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/data/models/DistanceTimeModel.dart';
import 'package:fulltrip/data/models/lot.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/widgets/description_text/description_text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LotDetails extends StatefulWidget {
  LotDetails({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LotDetailsState();
}

class _LotDetailsState extends State<LotDetails> {
  var myFormat = DateFormat('d-MM-yyyy');
  Lot lot;
  var startingaddress = [];
  var arrivaladdress = [];
  List startinglatlong = [];
  List arrivallatlong = [];
  double distanceinKm = 0.0;
  String time = '';
  Future<DistanceTimeModel> distanceTimeModel;

  calculateDistance() async {
    //Start
    List<Placemark> startingAddresplacemark = await Geolocator().placemarkFromAddress(lot.startingAddress);
    Placemark startingplace = startingAddresplacemark[0];
    startinglatlong = [startingplace.position.latitude, startingplace.position.longitude];
    //Arrival
    List<Placemark> arrivalAddresplacemark = await Geolocator().placemarkFromAddress(lot.arrivalAddress);
    Placemark arrivalplace = arrivalAddresplacemark[0];
    arrivallatlong = [arrivalplace.position.latitude, arrivalplace.position.longitude];

    setState(() => Global.isLoading = true);
    fetchRequestGoogleApi(startinglatlong[0], startinglatlong[1], arrivallatlong[0], arrivallatlong[1]).then((value) {
      var rows = value.rows;
      rows.forEach((element) {
        var elements = element.elements;
        elements.forEach((innerelement) {
          int distanceinM = innerelement.distance.value;
          if (mounted) {
            setState(() {
              Global.isLoading = false;
              distanceinKm = (distanceinM / 1000);
              time = innerelement.duration.text;
            });
          }
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  initLot() {
    final LinkedHashMap<String, Lot> args = ModalRoute.of(context).settings.arguments;
    if (args == null) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        lot = args['lot'];
        startingaddress = lot.startingAddress.split(',');
        arrivaladdress = lot.arrivalAddress.split(',');
      });
    }
    calculateDistance();
  }

  @override
  Widget build(BuildContext context) {
    if (lot == null) {
      initLot();
    }

    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 146,
                            margin: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              image: lot.photo != ''
                                  ? DecorationImage(
                                      image: NetworkImage(lot.photo),
                                      fit: BoxFit.cover,
                                    )
                                  : DecorationImage(
                                      image: this.lot.photo != '' ? NetworkImage(lot.photo) : AssetImage("assets/images/noimage.png"),
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16, bottom: 32),
                            child: Row(
                              children: [
                                Icon(AntDesign.calendar, size: 14, color: AppColors.greyColor),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text('Publié le ${myFormat.format(lot.date)}', style: AppStyles.blackTextStyle.copyWith(fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 4, right: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Entypo.circle, size: 9, color: AppColors.darkGreyColor),
                                      Dash(
                                        direction: Axis.vertical,
                                        length: 48,
                                        dashLength: 3,
                                        dashColor: AppColors.darkGreyColor,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      startingaddress.length >= 2
                                          ? Text(
                                              "${startingaddress[startingaddress.length - 2]},${startingaddress[startingaddress.length - 1]}",
                                              style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                            )
                                          : Text(
                                              "${startingaddress[startingaddress.length - 1]}",
                                              style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                      Container(
                                        child: Text(
                                          lot.startingAddress,
                                          style: AppStyles.greyTextStyle.copyWith(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 16, top: 16),
                            child: Text('$time  ($distanceinKm km)', style: AppStyles.blackTextStyle.copyWith(fontSize: 12)),
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Dash(
                                        direction: Axis.vertical,
                                        length: 48,
                                        dashLength: 3,
                                        dashColor: AppColors.darkGreyColor,
                                      ),
                                      Icon(Entypo.circle, size: 9, color: AppColors.darkGreyColor),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      arrivaladdress.length >= 2
                                          ? Text(
                                              "${arrivaladdress[arrivaladdress.length - 2]},${arrivaladdress[arrivaladdress.length - 1]}",
                                              style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                            )
                                          : Text(
                                              "${arrivaladdress[arrivaladdress.length - 1]}",
                                              style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                      Container(
                                        child: Text(
                                          lot.arrivalAddress,
                                          style: AppStyles.greyTextStyle.copyWith(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Divider(
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text('Prestation', style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
                          ),
                          Text(lot.delivery, style: AppStyles.greyTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 18)),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Divider(
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text('La description', style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14)),
                          ),
                          DescriptionText(
                            text: lot.description,
                            minLength: 140,
                            textStyle: AppStyles.greyTextStyle.copyWith(fontSize: 10, fontWeight: FontWeight.w300, height: 1.3),
                            moreTextStyle: AppStyles.primaryTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 10, height: 1.4),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8, bottom: 4),
                            child: Divider(
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Prix de l\'expédition', style: AppStyles.blackTextStyle.copyWith(fontSize: 18)),
                              Container(
                                margin: EdgeInsets.only(left: 24),
                                child: Text('${lot.price.toStringAsFixed(0)}€', style: AppStyles.darkGreyTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 24)),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8, top: 4),
                            child: Divider(
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text('NOM DE LA COMPAGNIE', style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8, bottom: 24),
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Icon(Feather.message_square, size: 18, color: AppColors.primaryColor),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text('Contacter l\'entreprise', style: AppStyles.primaryTextStyle.copyWith(fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: AppColors.primaryColor.withOpacity(0.24), blurRadius: 16, spreadRadius: 4),
                              ],
                            ),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              height: 60,
                              child: RaisedButton(
                                child: Text('Réservez cet article', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                color: AppColors.primaryColor,
                                textColor: Colors.white,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
