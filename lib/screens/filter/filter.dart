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
  List<double> price = [500, 3500];
  List<double> volume = [16];
  String startAddress = '';
  String arrivalAddress = '';
  bool disAssemble = false;
  bool reAssemble = false;
  String unservice;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.greenColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
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
              onTap: () => {},
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
                            margin: EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Adresse de départ', style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                                FormFieldContainer(
                                  padding: EdgeInsets.only(right: 16),
                                  child: GooglePlacesAutocomplete(
                                    initialValue: '',
                                    prefixIcon: Icon(Entypo.location_pin, color: AppColors.greenColor),
                                    onSelect: (val) => this.setState(() => startAddress = val),
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
                                    initialValue: '',
                                    prefixIcon: Icon(Entypo.location_pin, color: AppColors.purpleColor),
                                    onSelect: (val) => this.setState(() => arrivalAddress = val),
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
                                    min: 100,
                                    max: 10000,
                                    values: price,
                                    rangeSlider: true,
                                    step: FlutterSliderStep(step: 1),
                                    selectByTap: true,
                                    onDragging: (handlerIndex, lowerValue, upperValue) {
                                      setState(() {
                                        price = [lowerValue, upperValue];
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
                                    min: 5,
                                    max: 100,
                                    values: volume,
                                    step: FlutterSliderStep(step: 1),
                                    selectByTap: true,
                                    onDragging: (handlerIndex, lowerValue, upperValue) {
                                      setState(() {
                                        volume = [lowerValue, upperValue];
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
                                  child: Text(itm.value, style: AppStyles.blackTextStyle.copyWith(fontSize: 14),),
                                );
                              }).toList(),
                              value: unservice,
                              onChanged: (val) {
                                setState(() {
                                  unservice = val;
                                });
                              },
                              decoration: hintTextDecoration('Choisissez votre service'),
                              onSaved: (val) => setState(() => unservice = val),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 64),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.24),
                                  blurRadius: 16,
                                  spreadRadius: 4
                                ),
                              ],
                            ),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              height: 60,
                              child: RaisedButton(
                                child: Text('Appliquer les filtres', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
