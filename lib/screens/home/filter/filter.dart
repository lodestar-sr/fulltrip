import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List<int> price = [0, 10000];
  List<int> quantity = [0];
  String startingAddress = '';
  String arrivalAddress = '';
  String delivery = '';

  @override
  void initState() {
    super.initState();
    initFilter();
  }

  initFilter() {
    setState(() {
      startingAddress = Global.filter.startingAddress;
      arrivalAddress = Global.filter.arrivalAddress;
      quantity = [Global.filter.quantity];
      price = [Global.filter.lowPrice, Global.filter.highPrice];
      delivery = Global.filter.delivery;
    });
  }

  resetFilter() {
    setState(() {
      price = [0, 10000];
      quantity = [0];
      startingAddress = '';
      arrivalAddress = '';
      delivery = '';
    });
  }

  saveFilter() {
    if (startingAddress != '') {
      setState(() => Global.filter.startingAddress = startingAddress);
    }

    if (arrivalAddress != '') {
      setState(() => Global.filter.arrivalAddress = startingAddress);
    }

    if (quantity[0] != 0) {
      setState(() => Global.filter.quantity = quantity[0]);
    }

    if (delivery != '') {
      setState(() => Global.filter.delivery = delivery);
    }

    if (price[0] != 0) {
      setState(() => Global.filter.lowPrice = price[0]);
    }

    if (price[0] != 10000) {
      setState(() => Global.filter.highPrice = price[1]);
    }

    Navigator.of(context).popAndPushNamed('dashboard');
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
          title: new Text('Filtres', style: TextStyle(fontSize: 17, color: AppColors.darkColor)),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Text('Annuler', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
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
                  child: Text('Réinitialiser', style: AppStyles.primaryTextStyle.copyWith(fontSize: 12)),
                ),
              ),
              onTap: resetFilter,
            )
          ],
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
                            margin: EdgeInsets.only(bottom: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Adresse de départ', style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                                FormFieldContainer(
                                  padding: EdgeInsets.only(right: 16),
                                  child: GooglePlacesAutocomplete(
                                    initialValue: startingAddress,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Image.asset('assets/images/locationDeparture.png', width: 16, height: 16),
                                    ),
                                    onSelect: (val) => setState(() => startingAddress = val),
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
                                Text('Adresse d\'arrivée', style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                                FormFieldContainer(
                                  padding: EdgeInsets.only(right: 16),
                                  child: GooglePlacesAutocomplete(
                                    initialValue: arrivalAddress,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Image.asset('assets/images/locationArrival.png', width: 16, height: 16),
                                    ),
                                    onSelect: (val) => setState(() => arrivalAddress = val),
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
                                Text('Prix', style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: FlutterSlider(
                                    min: 0,
                                    max: 10000,
                                    values: price.map((i) => i.toDouble()).toList(),
                                    rangeSlider: true,
                                    step: FlutterSliderStep(step: 1),
                                    selectByTap: true,
                                    onDragging: (handlerIndex, lowerValue, upperValue) {
                                      setState(() {
                                        price = [lowerValue.toInt(), upperValue.toInt()];
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
                                        child: Icon(Icons.check, color: Colors.white, size: 12),
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
                                        child: Icon(Icons.check, color: Colors.white, size: 12),
                                      ),
                                    ),
                                    trackBar: FlutterSliderTrackBar(
                                      activeTrackBarHeight: 5,
                                      inactiveTrackBarHeight: 5,
                                      activeTrackBar: BoxDecoration(color: AppColors.primaryColor),
                                      inactiveTrackBar: BoxDecoration(color: AppColors.lightGreyColor),
                                    ),
                                    tooltip: FlutterSliderTooltip(
                                      positionOffset: FlutterSliderTooltipPositionOffset(top: -5),
                                      alwaysShowTooltip: true,
                                      custom: (value) => Text('${value.toString()}€', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                                    ),
                                    hatchMark: FlutterSliderHatchMark(labels: [
                                      FlutterSliderHatchMarkLabel(percent: 0, label: Text('100', style: AppStyles.greyTextStyle.copyWith(fontSize: 12))),
                                      FlutterSliderHatchMarkLabel(percent: 100, label: Text('10000', style: AppStyles.greyTextStyle.copyWith(fontSize: 12))),
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
                                Text('Quantité', style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: FlutterSlider(
                                    min: 0,
                                    max: 100,
                                    values: quantity.map((i) => i.toDouble()).toList(),
                                    step: FlutterSliderStep(step: 1),
                                    selectByTap: true,
                                    onDragging: (handlerIndex, lowerValue, upperValue) {
                                      setState(() {
                                        quantity = [lowerValue.toInt()];
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
                                        child: Icon(Icons.check, color: Colors.white, size: 12),
                                      ),
                                    ),
                                    trackBar: FlutterSliderTrackBar(
                                      activeTrackBarHeight: 5,
                                      inactiveTrackBarHeight: 5,
                                      activeTrackBar: BoxDecoration(color: AppColors.primaryColor),
                                      inactiveTrackBar: BoxDecoration(color: AppColors.lightGreyColor),
                                    ),
                                    tooltip: FlutterSliderTooltip(
                                      positionOffset: FlutterSliderTooltipPositionOffset(top: -5),
                                      alwaysShowTooltip: true,
                                      custom: (value) => Text('${value.toString()}m³', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                                    ),
                                    hatchMark: FlutterSliderHatchMark(labels: [
                                      FlutterSliderHatchMarkLabel(percent: 0, label: Text('5m³', style: AppStyles.greyTextStyle.copyWith(fontSize: 12))),
                                      FlutterSliderHatchMarkLabel(percent: 100, label: Text('100m³', style: AppStyles.greyTextStyle.copyWith(fontSize: 12))),
                                    ], labelsDistanceFromTrackBar: 30),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FormFieldContainer(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.only(left: 20),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: [
                                    DropdownMenuItem(
                                      value: '',
                                      child: Text(
                                        '',
                                        style: AppStyles.blackTextStyle.copyWith(fontSize: 14),
                                      ),
                                    )
                                  ] +
                                  Constants.services.entries.map((itm) {
                                    return DropdownMenuItem(
                                      value: itm.key,
                                      child: Text(
                                        itm.value,
                                        style: AppStyles.blackTextStyle.copyWith(fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                              value: delivery,
                              onChanged: (val) {
                                setState(() {
                                  delivery = val;
                                });
                              },
                              decoration: hintTextDecoration('Choisissez votre service'),
                              onSaved: (val) => setState(() => delivery = val),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 64),
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
                                child: Text('Appliquer les filtres', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
}
