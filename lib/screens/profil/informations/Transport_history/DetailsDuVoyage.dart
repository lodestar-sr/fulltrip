import 'package:Fulltrip/data/models/DistanceTimeModel.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DetailsDuVage extends StatefulWidget {
  DetailsDuVage({Key key}) : super(key: key);

  @override
  _DetailsDuVageState createState() => _DetailsDuVageState();
}

class _DetailsDuVageState extends State<DetailsDuVage> {
  var startingaddress = [];
  var arrivaladdress = [];
  List startinglatlong = [];
  List arrivallatlong = [];
  double distanceinKm = 0.0;
  String time = '';
  Future<DistanceTimeModel> distanceTimeModel;

  calculateDistance() async {
    //Start
    List<Placemark> startingAddresplacemark = await Geolocator().placemarkFromAddress('Paris,France');
    Placemark startingplace = startingAddresplacemark[0];
    startinglatlong = [startingplace.position.latitude, startingplace.position.longitude];
    //Arrival
    List<Placemark> arrivalAddresplacemark = await Geolocator().placemarkFromAddress('Nice,France');
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
    // TODO: implement initState
    super.initState();
    startingaddress = '40 Avenue Leon Blum,Paris,France'.split(',');
    arrivaladdress = "2-6 Rue Joseph d'Arbaud,Nice,France".split(',');
    calculateDistance();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.primaryColor,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: AppColors.backButtonColor, //change your color here
              ),
              title: Text(
                'Détails du voyage',
                style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
              ),
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
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                    Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/check.png',
                                            height: 24,
                                            width: 24,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Terminé",
                                                  style: AppStyles.primaryTextStyle.copyWith(fontSize: 14),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 5.0),
                                                  child: Text(
                                                    "Date de création: 30 juin 2020",
                                                    style: AppStyles.navbarInactiveTextStyle.copyWith(color: AppColors.mediumGreyColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Text(
                                      'Ordre',
                                      style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 4, right: 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset('assets/images/circle.png', width: 12, height: 12),
                                                  Container(
                                                      padding: EdgeInsets.only(top: 2),
                                                      width: 9,
                                                      child: Dash(
                                                        direction: Axis.vertical,
                                                        length: 48,
                                                        dashLength: 48,
                                                        dashColor: AppColors.darkGreyColor,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  startingaddress.length >= 2
                                                      ? Text(
                                                          "${startingaddress[startingaddress.length - 2].toString().trim()},${startingaddress[startingaddress.length - 1].toString().trim()}",
                                                          style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                                        )
                                                      : Text(
                                                          "${startingaddress[startingaddress.length - 1].toString().trim()}",
                                                          style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                                        ),
                                                  Container(
                                                    padding: EdgeInsets.only(top: 3.0),
                                                    child: Text(
                                                      '40 Avenue Leon Blum',
                                                      style: AppStyles.greyTextStyle.copyWith(fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 16, top: 16, left: 8),
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
                                                Container(
                                                    width: 9,
                                                    child: Dash(
                                                      direction: Axis.vertical,
                                                      length: 48,
                                                      dashLength: 48,
                                                      dashColor: AppColors.darkGreyColor,
                                                    )),
                                                Image.asset('assets/images/triangle.png', width: 12, height: 12),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                arrivaladdress.length >= 2
                                                    ? Text(
                                                        "${arrivaladdress[arrivaladdress.length - 2].toString().trim()},${arrivaladdress[arrivaladdress.length - 1].toString().trim()}",
                                                        style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                                      )
                                                    : Text(
                                                        "${arrivaladdress[arrivaladdress.length - 1]}",
                                                        style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                                      ),
                                                Container(
                                                  padding: EdgeInsets.only(top: 3.0),
                                                  child: Text(
                                                    "2-6 Rue Joseph d'Arbaud",
                                                    style: AppStyles.greyTextStyle.copyWith(fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Text(
                                      'Rapport',
                                      style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 15, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Le coût du voyage........................................",
                                            style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '500€',
                                            style: AppStyles.primaryTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]))))));
            })));
  }
}
