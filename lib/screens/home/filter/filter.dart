import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:fulltrip/util/constants.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:fulltrip/widgets/google_place_autocomplete/google_place_autocomplete.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Filter extends StatefulWidget {
  Filter({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<double> price = [0, 10000];
  List<double> volume = [16];
  String startAddress = '';
  String arrivalAddress = '';
  String startcity = '';
  String arrivalcity = '';
  bool disAssemble = false;
  bool reAssemble = false;
  String unservice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setvaluesfromData();
  }

  setvaluesfromData() {
    if (Global.filterdata.isNotEmpty) {
      Global.filterdata.forEach((element) {
        if (element['type'] == 'start_address') {
          setState(() {
            startAddress = element['value'];
          });
        }
        if (element['type'] == 'arrival_address') {
          setState(() {
            arrivalAddress = element['value'];
          });
        }
        if (element['type'] == 'price') {
          setState(() {
            price = [element['lowValue'], element['highValue']];
          });
        }
        if (element['type'] == 'volume') {
          setState(() {
            volume = [element['value']];
          });
        }
        if (element['type'] == 'service') {
          setState(() {
            unservice = element['value'];
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: new Text('Filtres',
              style: TextStyle(fontSize: 17, color: AppColors.darkColor)),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Text('Annuler',
                    style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
              ),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            GestureDetector(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Text('Réinitialiser',
                      style: AppStyles.primaryTextStyle.copyWith(fontSize: 12)),
                ),
              ),
              onTap: () => setState(() => Global.filterdata.clear()),
            )
          ],
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
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
                            margin: EdgeInsets.only(bottom: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Adresse de départ',
                                    style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                FormFieldContainer(
                                  padding: EdgeInsets.only(right: 16),
                                  child: GooglePlacesAutocomplete(
                                    initialValue: startAddress,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Image.asset(
                                        'assets/images/locationDeparture.png',
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                    onSelect: (val) => this.setState(() {
                                      startAddress = val;
                                      var fullstart = val.toString().split(",");
                                      startcity = fullstart.length >= 2
                                          ? fullstart[fullstart.length - 2]
                                          : fullstart[fullstart.length - 1];
                                      print(startcity);
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Adresse d\'arrivée',
                                    style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                FormFieldContainer(
                                  padding: EdgeInsets.only(right: 16),
                                  child: GooglePlacesAutocomplete(
                                    initialValue: arrivalAddress,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Image.asset(
                                        'assets/images/locationArrival.png',
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                    onSelect: (val) => this.setState(() {
                                      arrivalAddress = val;
                                      var fullarrival =
                                          val.toString().split(",");
                                      arrivalcity = fullarrival.length >= 2
                                          ? fullarrival[fullarrival.length - 2]
                                          : fullarrival[fullarrival.length - 1];
                                      print(arrivalcity);
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.lightGreyColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Prix',
                                    style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: FlutterSlider(
                                    min: 0,
                                    max: 10000,
                                    values: price,
                                    rangeSlider: true,
                                    step: FlutterSliderStep(step: 1),
                                    selectByTap: true,
                                    onDragging:
                                        (handlerIndex, lowerValue, upperValue) {
                                      setState(() {
                                        price = [lowerValue, upperValue];
                                        print('lowervalue : $lowerValue');
                                        print('uppervalue : $upperValue');
                                      });
                                    },
                                    handlerWidth: 24,
                                    handlerHeight: 24,
                                    handler: FlutterSliderHandler(
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: new BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            AppColors.primaryColor,
                                            AppColors.whiteColor,
                                          ]),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.check,
                                            color: Colors.white, size: 12),
                                      ),
                                    ),
                                    rightHandler: FlutterSliderHandler(
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: new BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            AppColors.primaryColor,
                                            AppColors.whiteColor,
                                          ]),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.check,
                                            color: Colors.white, size: 12),
                                      ),
                                    ),
                                    trackBar: FlutterSliderTrackBar(
                                      activeTrackBarHeight: 5,
                                      inactiveTrackBarHeight: 5,
                                      activeTrackBar: BoxDecoration(
                                          color: AppColors.primaryColor),
                                      inactiveTrackBar: BoxDecoration(
                                          color: AppColors.lightGreyColor),
                                    ),
                                    tooltip: FlutterSliderTooltip(
                                      positionOffset:
                                          FlutterSliderTooltipPositionOffset(
                                              top: -5),
                                      alwaysShowTooltip: true,
                                      custom: (value) => Text(
                                          '${value.toString()}€',
                                          style: AppStyles.greyTextStyle
                                              .copyWith(fontSize: 12)),
                                    ),
                                    hatchMark: FlutterSliderHatchMark(labels: [
                                      FlutterSliderHatchMarkLabel(
                                          percent: 0,
                                          label: Text('100',
                                              style: AppStyles.greyTextStyle
                                                  .copyWith(fontSize: 12))),
                                      FlutterSliderHatchMarkLabel(
                                          percent: 100,
                                          label: Text('10000',
                                              style: AppStyles.greyTextStyle
                                                  .copyWith(fontSize: 12))),
                                    ], labelsDistanceFromTrackBar: 30),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Quantité',
                                    style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: FlutterSlider(
                                    min: 1,
                                    max: 100,
                                    values: volume,
                                    step: FlutterSliderStep(step: 1),
                                    selectByTap: true,
                                    onDragging:
                                        (handlerIndex, lowerValue, upperValue) {
                                      setState(() {
                                        volume = [lowerValue];
                                      });
                                    },
                                    handlerWidth: 24,
                                    handlerHeight: 24,
                                    handler: FlutterSliderHandler(
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: new BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            AppColors.primaryColor,
                                            AppColors.whiteColor,
                                          ]),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.check,
                                            color: Colors.white, size: 12),
                                      ),
                                    ),
                                    trackBar: FlutterSliderTrackBar(
                                      activeTrackBarHeight: 5,
                                      inactiveTrackBarHeight: 5,
                                      activeTrackBar: BoxDecoration(
                                          color: AppColors.primaryColor),
                                      inactiveTrackBar: BoxDecoration(
                                          color: AppColors.lightGreyColor),
                                    ),
                                    tooltip: FlutterSliderTooltip(
                                      positionOffset:
                                          FlutterSliderTooltipPositionOffset(
                                              top: -5),
                                      alwaysShowTooltip: true,
                                      custom: (value) => Text(
                                          '${value.toString()}m³',
                                          style: AppStyles.greyTextStyle
                                              .copyWith(fontSize: 12)),
                                    ),
                                    hatchMark: FlutterSliderHatchMark(labels: [
                                      FlutterSliderHatchMarkLabel(
                                          percent: 0,
                                          label: Text('5m³',
                                              style: AppStyles.greyTextStyle
                                                  .copyWith(fontSize: 12))),
                                      FlutterSliderHatchMarkLabel(
                                          percent: 100,
                                          label: Text('100m³',
                                              style: AppStyles.greyTextStyle
                                                  .copyWith(fontSize: 12))),
                                    ], labelsDistanceFromTrackBar: 30),
                                  ),
                                ),
                              ],
                            ),
                          ),
//                          Container(
//                              child: SwitchListTile(
//                            title: Text('Démontage des meubles ?', style: AppStyles.greyTextStyle.copyWith(color: AppColors.darkGreyColor, fontSize: 13)),
//                            value: disAssemble,
//                            onChanged: (val) => this.setState(() => disAssemble = val),
//                          )),
//                          Container(
//                            child: SwitchListTile(
//                              title: Text('Remontage des meubles ?', style: AppStyles.greyTextStyle.copyWith(color: AppColors.darkGreyColor, fontSize: 13)),
//                              value: reAssemble,
//                              onChanged: (val) => this.setState(() => reAssemble = val),
//                            ),
//                          ),
                          FormFieldContainer(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.only(left: 20),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: Constants.services.entries.map((itm) {
                                return DropdownMenuItem(
                                  value: itm.key,
                                  child: Text(
                                    itm.value,
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              value: unservice,
                              onChanged: (val) {
                                setState(() {
                                  unservice = val;
                                });
                              },
                              decoration: hintTextDecoration(
                                  'Choisissez votre service'),
                              onSaved: (val) => setState(() => unservice = val),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 64),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.primaryColor
                                        .withOpacity(0.24),
                                    blurRadius: 16,
                                    spreadRadius: 4),
                              ],
                            ),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              height: 60,
                              child: RaisedButton(
                                child: Text('Appliquer les filtres',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                color: AppColors.primaryColor,
                                textColor: Colors.white,
                                onPressed: () => saveFilter(),
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

  saveFilter() {
    bool startaddresscheck = false;
    bool arrivaladdresscheck = false;
    bool volumecheck = false;
    bool pricecheck = false;
    bool servicecheck = false;
    if (Global.filterdata.isNotEmpty) {
      for (int i = 0; i < Global.filterdata.length; i++) {
        if (startAddress != '') {
          if (Global.filterdata[i]['type'] == 'start_address') {
            Global.filterdata[i].update('value', (value) => startcity);
            startaddresscheck = true;
          }
        }
        if (arrivalAddress != '') {
          if (Global.filterdata[i]['type'] == 'arrival_address') {
            Global.filterdata[i].update('value', (value) => arrivalcity);
            arrivaladdresscheck = true;
          }
        }

        if (volume.isNotEmpty) {
          if (Global.filterdata[i]['type'] == 'volume') {
            Global.filterdata[i].update('value', (value) => volume[0]);
            volumecheck = true;
          }
        }

        if (unservice != null) {
          if (Global.filterdata[i]['type'] == 'service') {
            Global.filterdata[i].update('value', (value) => unservice);
            servicecheck = true;
          }
        }

        if (price.isNotEmpty) {
          if (Global.filterdata[i]['type'] == 'price') {
            Global.filterdata[i].update('lowValue', (value) => price[0]);
            Global.filterdata[i].update('highValue', (value) => price[1]);
            pricecheck = true;
          }
        }
      }
      if (!startaddresscheck) {
        if (startAddress != '') {
          Global.filterdata.add({"type": 'start_address', "value": startcity});
        }
      }
      if (!arrivaladdresscheck) {
        if (arrivalAddress != '') {
          Global.filterdata
              .add({"type": 'arrival_address', "value": arrivalcity});
        }
      }
      if (!volumecheck) {
        if (volume.isNotEmpty) {
          Global.filterdata.add({'type': 'volume', 'value': volume[0]});
        }
      }
      if (!servicecheck) {
        if (unservice != null) {
          Global.filterdata.add({'type': 'service', 'value': unservice});
        }
      }
      if (!pricecheck) {
        if (price.isNotEmpty) {
          Global.filterdata.add(
              {'type': 'price', 'lowValue': price[0], 'highValue': price[1]});
        }
      }
    } else {
      if (startAddress != '') {
        Global.filterdata.add({"type": 'start_address', "value": startcity});
      }
      if (arrivalAddress != '') {
        Global.filterdata
            .add({"type": 'arrival_address', "value": arrivalcity});
      }
      if (price.isNotEmpty) {
        Global.filterdata.add(
            {'type': 'price', 'lowValue': price[0], 'highValue': price[1]});
      }
      if (volume.isNotEmpty) {
        Global.filterdata.add({'type': 'volume', 'value': volume[0]});
      }
      if (unservice != null) {
        Global.filterdata.add({'type': 'service', 'value': unservice});
      }
      Navigator.of(context).popAndPushNamed('dashboard');
    }
    Navigator.of(context).popAndPushNamed('dashboard');
  }
}
