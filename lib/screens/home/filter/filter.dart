import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:Fulltrip/widgets/google_place_autocomplete/google_place_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Filter extends StatefulWidget {
  Filter({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final pickupDateController = TextEditingController();
  final deliveryDateController = TextEditingController();
  final dateFormat = DateFormat('MM/dd/yyyy');

  List<int> price = [0, 10000];
  List<int> quantity = [0];
  String startingAddress = '';
  String arrivalAddress = '';
  String delivery = '';
  DateTime pickUpDate;
  DateTime deliveryDate;

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
      pickUpDate = Global.filter.pickUpDate;
      deliveryDate = Global.filter.deliveryDate;
      pickupDateController.text =
          pickUpDate != null ? dateFormat.format(pickUpDate) : '';
      deliveryDateController.text =
          deliveryDate != null ? dateFormat.format(deliveryDate) : '';
    });
  }

  resetFilter() {
    setState(() {
      price = [0, 10000];
      quantity = [0];
      startingAddress = '';
      arrivalAddress = '';
      delivery = '';
      pickupDateController.text = '';
      deliveryDateController.text = '';
      pickUpDate = null;
      deliveryDate = null;
    });
  }

  saveFilter() {
    setState(() {
      Global.filter.startingAddress = startingAddress;
      Global.filter.arrivalAddress = arrivalAddress;
      Global.filter.quantity = quantity[0];
      Global.filter.delivery = delivery;
      Global.filter.lowPrice = price[0];
      Global.filter.highPrice = price[1];
      Global.filter.pickUpDate = pickUpDate;
      Global.filter.deliveryDate = deliveryDate;
    });

    Navigator.of(context)
        .pushNamedAndRemoveUntil('dashboard', (Route<dynamic> route) => false);
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
          iconTheme: IconThemeData(
            color: AppColors.backButtonColor, //change your color here
          ),
          title: Text('Filtrer',
              style: TextStyle(fontSize: 20, color: AppColors.darkColor)),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              child: Center(
                child: Container(
                    padding: EdgeInsets.only(right: 7),
                    child: Text('Annuler Filtres',
                        style: AppStyles.primaryTextStyle.copyWith(
                            fontSize: 14, color: AppColors.resetFilterColors))),
              ),
              onTap: resetFilter,
            ),
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
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColors.lightGreyColor
                                            .withOpacity(0.6)),
                                  ),
                                  child: GooglePlacesAutocomplete(
                                    initialValue: startingAddress,
                                    hintText: 'Adresse précise, ville',
                                    underline: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Icon(
                                          MaterialCommunityIcons.circle_slice_8,
                                          size: 16,
                                          color: AppColors.primaryColor),
                                    ),
                                    onSelect: (val) =>
                                        setState(() => startingAddress = val),
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColors.lightGreyColor
                                            .withOpacity(0.6)),
                                  ),
                                  child: GooglePlacesAutocomplete(
                                    initialValue: arrivalAddress,
                                    hintText: 'Adresse précise, ville',
                                    underline: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Icon(Feather.map_pin,
                                          size: 16, color: AppColors.redColor),
                                    ),
                                    onSelect: (val) =>
                                        setState(() => arrivalAddress = val),
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: FlutterSlider(
                                          min: 0,
                                          max: 10000,
                                          values: price
                                              .map((i) => i.toDouble())
                                              .toList(),
                                          rangeSlider: true,
                                          step: FlutterSliderStep(step: 100),
                                          selectByTap: true,
                                          onDragging: (handlerIndex, lowerValue,
                                              upperValue) {
                                            setState(() {
                                              price = [
                                                lowerValue.toInt(),
                                                upperValue.toInt()
                                              ];
                                            });
                                          },
                                          handlerWidth: 20,
                                          handlerHeight: 20,
                                          handler: FlutterSliderHandler(
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.primaryColor,
                                                    width: 2),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                          rightHandler: FlutterSliderHandler(
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.primaryColor,
                                                    width: 2),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                          trackBar: FlutterSliderTrackBar(
                                            activeTrackBarHeight: 2,
                                            inactiveTrackBarHeight: 2,
                                            activeTrackBar: BoxDecoration(
                                                color: AppColors.primaryColor),
                                            inactiveTrackBar: BoxDecoration(
                                                color:
                                                    AppColors.lightGreyColor),
                                          ),
                                          tooltip: FlutterSliderTooltip(
                                            positionOffset:
                                                FlutterSliderTooltipPositionOffset(
                                              top: 35,
                                            ),
                                            alwaysShowTooltip: true,
                                            custom: (value) => Text(
                                                '${value.toStringAsFixed(0)}€',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Quantité ',
                                    style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: FlutterSlider(
                                          min: 0,
                                          max: 100,
                                          values: quantity
                                              .map((i) => i.toDouble())
                                              .toList(),
                                          step: FlutterSliderStep(step: 5),
                                          selectByTap: true,
                                          onDragging: (handlerIndex, lowerValue,
                                              upperValue) {
                                            setState(() {
                                              quantity = [lowerValue.toInt()];
                                            });
                                          },
                                          handlerWidth: 20,
                                          handlerHeight: 20,
                                          handler: FlutterSliderHandler(
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.primaryColor,
                                                    width: 2),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                          trackBar: FlutterSliderTrackBar(
                                            activeTrackBarHeight: 2,
                                            inactiveTrackBarHeight: 2,
                                            activeTrackBar: BoxDecoration(
                                                color: AppColors.primaryColor),
                                            inactiveTrackBar: BoxDecoration(
                                                color:
                                                    AppColors.lightGreyColor),
                                          ),
                                          tooltip: FlutterSliderTooltip(
                                            positionOffset:
                                                FlutterSliderTooltipPositionOffset(
                                              top: 35,
                                            ),
                                            alwaysShowTooltip: true,
                                            custom: (value) => Text(
                                                '≤${value.toStringAsFixed(0)}m³',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 24),
                            child: Text(
                              "Période d'enlèvement",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          FormFieldContainer(
                            margin: EdgeInsets.only(top: 10, bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.lightGreyColor
                                      .withOpacity(0.6)),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              controller: pickupDateController,
                              decoration: hintTextDecoration('entre le')
                                  .copyWith(
                                      prefixIcon: Icon(MaterialCommunityIcons
                                          .calendar_range),
                                      contentPadding: EdgeInsets.only(top: 15),
                                      border: InputBorder.none),
                              onTap: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime.now().add(
                                    Duration(days: 90),
                                  ),
                                  onConfirm: (date) {
                                    setState(() => pickUpDate = date);
                                    pickupDateController.text =
                                        dateFormat.format(pickUpDate);
                                  },
                                  currentTime: pickUpDate == null
                                      ? DateTime.now()
                                      : pickUpDate,
                                  locale: LocaleType.fr,
                                );
                              },
                              style: AppStyles.blackTextStyle
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'Période de livraison souhaitée',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          FormFieldContainer(
                            margin: EdgeInsets.only(top: 10, bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.lightGreyColor
                                      .withOpacity(0.6)),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              controller: deliveryDateController,
                              decoration: hintTextDecoration('entre le')
                                  .copyWith(
                                      prefixIcon: Icon(MaterialCommunityIcons
                                          .calendar_range),
                                      contentPadding: EdgeInsets.only(top: 15),
                                      border: InputBorder.none),
                              onTap: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime.now().add(
                                    Duration(days: 90),
                                  ),
                                  onConfirm: (date) {
                                    setState(() => deliveryDate = date);
                                    deliveryDateController.text =
                                        dateFormat.format(deliveryDate);
                                  },
                                  currentTime: deliveryDate == null
                                      ? DateTime.now()
                                      : deliveryDate,
                                  locale: LocaleType.fr,
                                );
                              },
                              style: AppStyles.blackTextStyle
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 64),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
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
                                child: Text('Afficher les résultats',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                color: AppColors.primaryColor,
                                textColor: Colors.white,
                                onPressed: () => saveFilter(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
