import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/size_config.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/util/user_current_location.dart';
import 'package:fulltrip/util/validators/validators.dart';
import 'package:fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:fulltrip/widgets/google_place_autocomplete/google_place_autocomplete.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProposeLot extends StatefulWidget {
  ProposeLot({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposeLotState();
}

class _ProposeLotState extends State<ProposeLot> {
  final _formKey = GlobalKey<FormState>();
  final pickupDateFromController = TextEditingController();
  final pickupDateToController = TextEditingController();
  final dateFormat = DateFormat('MM/dd/yyyy');

  Location location = new Location();
  bool _serviceEnabled;
  bool checkquantity = false;

  @override
  void initState() {
    super.initState();
    pickupDateFromController.text = Global.lotForm.pickupDateFrom != null
        ? dateFormat.format(Global.lotForm.pickupDateFrom)
        : '';
    pickupDateToController.text = Global.lotForm.pickupDateTo != null
        ? dateFormat.format(Global.lotForm.pickupDateTo)
        : '';
  }

  goToNext() {
    if (_formKey.currentState.validate() && Global.lotForm.quantity != 0) {
      setState(() {
        checkquantity = false;
      });
      Navigator.of(context).pushNamed('ProposeLot2');
    } else if (Global.lotForm.quantity == 0) {
      setState(() {
        checkquantity = true;
      });
    }
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
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                child: Center(
                  child: Container(
                      child: Text('Précédent',
                          style:
                              AppStyles.greyTextStyle.copyWith(fontSize: 14))),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              Text('Au départ',
                  style: TextStyle(fontSize: 20, color: AppColors.darkColor)),
              GestureDetector(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Text('Fermer',
                        style: AppStyles.greyTextStyle.copyWith(fontSize: 14)),
                  ),
                ),
                onTap: () => Navigator.of(context).popAndPushNamed('dashboard'),
              )
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: <Widget>[],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return Form(
              key: _formKey,
              autovalidate: true,
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Adresse de départ',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.redColor)),
                              ],
                            ),
                          ),
                          FormFieldContainer(
                            padding: EdgeInsets.only(right: 16, left: 16),
                            child: GooglePlacesAutocomplete(
                              initialValue: Global.lotForm.startingAddress,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 13, 26, 13),
                                child: Image.asset(
                                    'assets/images/locationDeparture.png',
                                    width: 13,
                                    height: 13),
                              ),
                              validator: (value) => Validators.required(value,
                                  errorText: 'Adresse de départ est requis'),
                              onSelect: (val) => this.setState(
                                  () => Global.lotForm.startingAddress = val),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: GestureDetector(
                              onTap: () async {
                                _serviceEnabled =
                                    await location.serviceEnabled();
                                if (!_serviceEnabled) {
                                  _serviceEnabled =
                                      await location.requestService();

                                  if (!_serviceEnabled) {
                                    return UserCurrentLocation
                                        .checkpermissionstatus();
                                  }
                                } else {
                                  UserCurrentLocation.getCurrentLocation()
                                      .then((value) {
                                    setState(() {
                                      Global.lotForm.startingAddress =
                                          Global.address;
                                    });
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.location_searching,
                                      color: AppColors.primaryColor),
                                  SizedBox(width: 5),
                                  Text(
                                    'Utilise ma location',
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 2),
                            child: RichText(
                              text: TextSpan(
                                text: 'Type de lieu',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.darkColor,
                                    fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.redColor)),
                                ],
                              ),
                            ),
                          ),
                          FormFieldContainer(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 16),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: Global.typedelieu.map((itm) {
                                return DropdownMenuItem(
                                    value: itm,
                                    child: Text(itm,
                                        style: AppStyles.blackTextStyle
                                            .copyWith(fontSize: 14)));
                              }).toList(),
                              validator: (value) => Validators.required(value,
                                  errorText: 'Type de lieu est requis'),
                              onChanged: (val) {
                                setState(() {
                                  Global.lotForm.startingLocationType = val;
                                });
                              },
                              value: Global.lotForm.startingLocationType,
                              decoration: hintTextDecoration('Choisissez '),
                              onSaved: (val) => setState(() =>
                                  Global.lotForm.startingLocationType = val),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 2),
                            child: RichText(
                              text: TextSpan(
                                text: "Type d'accès",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.darkColor,
                                    fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.redColor)),
                                ],
                              ),
                            ),
                          ),
                          FormFieldContainer(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 16),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: Global.typedeacces.map((itm) {
                                return DropdownMenuItem(
                                    value: itm,
                                    child: Text(itm,
                                        style: AppStyles.blackTextStyle
                                            .copyWith(fontSize: 14)));
                              }).toList(),
                              validator: (value) => Validators.required(value,
                                  errorText: 'Type d\'accès est requis'),
                              onChanged: (val) {
                                setState(() {
                                  Global.lotForm.startingAccessType = val;
                                });
                              },
                              value: Global.lotForm.startingAccessType,
                              decoration: hintTextDecoration('Choisissez '),
                              onSaved: (val) => setState(() =>
                                  Global.lotForm.startingAccessType = val),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 2),
                            child: RichText(
                              text: TextSpan(
                                text: 'Etages',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.darkColor,
                                    fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.redColor)),
                                ],
                              ),
                            ),
                          ),
                          FormFieldContainer(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 16),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: Global.etages.map((itm) {
                                return DropdownMenuItem(
                                    value: itm,
                                    child: Text(itm,
                                        style: AppStyles.blackTextStyle
                                            .copyWith(fontSize: 14)));
                              }).toList(),
                              //value: starting_location_type,
                              validator: (value) => Validators.required(value,
                                  errorText: 'Etages est requis'),
                              onChanged: (val) {
                                setState(() {
                                  Global.lotForm.startingFloors = val;
                                });
                              },
                              value: Global.lotForm.startingFloors,
                              decoration: hintTextDecoration('Choisissez '),
                              onSaved: (val) => setState(
                                  () => Global.lotForm.startingFloors = val),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Monte meuble nécessaire',
                                  style: TextStyle(
                                      color: AppColors.darkGreyColor,
                                      fontSize: 14),
                                ),
                                CupertinoSwitch(
                                  activeColor: AppColors.primaryColor,
                                  value: Global.lotForm.startingFurnitureLift ==
                                      'Oui',
                                  onChanged: (bool value) {
                                    setState(() =>
                                        Global.lotForm.startingFurnitureLift =
                                            value ? 'Oui' : 'Non');
                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Color(0xffE4E4E4),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Démontage des meubles ?',
                                style: TextStyle(
                                    color: AppColors.darkGreyColor,
                                    fontSize: 14),
                              ),
                              CupertinoSwitch(
                                value: Global
                                        .lotForm.startingDismantlingFurniture ==
                                    'Oui',
                                activeColor: AppColors.primaryColor,
                                onChanged: (bool value) {
                                  setState(() => Global.lotForm
                                          .startingDismantlingFurniture =
                                      value ? 'Oui' : 'Non');
                                },
                              )
                            ],
                          ),

                          Divider(
                            color: Color(0xffE4E4E4),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 2),
                            child: Text(
                              'Période d\'enlèvement',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: FormFieldContainer(
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 16, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: pickupDateFromController,
                                    decoration: hintTextDecoration('entre le')
                                        .copyWith(
                                            prefixIcon:
                                                Icon(MaterialCommunityIcons.calendar_range)),
                                    onTap: () {
                                      DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        minTime: DateTime.now(),
                                        maxTime: DateTime.now().add(
                                          Duration(days: 90),
                                        ),
                                        onConfirm: (date) {
                                          setState(() => Global
                                              .lotForm.pickupDateFrom = date);
                                          pickupDateFromController.text =
                                              dateFormat.format(Global
                                                  .lotForm.pickupDateFrom);
                                        },
                                        currentTime:
                                            Global.lotForm.pickupDateFrom ==
                                                    null
                                                ? DateTime.now()
                                                : Global.lotForm.pickupDateFrom,
                                        locale: LocaleType.fr,
                                      );
                                    },
                                    style: AppStyles.blackTextStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: FormFieldContainer(
                                  margin: EdgeInsets.only(top: 10, bottom: 16),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: pickupDateToController,
                                    decoration: hintTextDecoration('et le')
                                        .copyWith(
                                            prefixIcon:
                                                Icon(MaterialCommunityIcons.calendar_range)),
                                    onTap: () {
                                      DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        minTime:
                                            Global.lotForm.pickupDateFrom ==
                                                    null
                                                ? DateTime.now()
                                                : Global.lotForm.pickupDateFrom,
                                        maxTime: (Global.lotForm
                                                        .pickupDateFrom ==
                                                    null
                                                ? DateTime.now()
                                                : Global.lotForm.pickupDateFrom)
                                            .add(
                                          Duration(days: 90),
                                        ),
                                        onConfirm: (date) {
                                          setState(() => Global
                                              .lotForm.pickupDateTo = date);
                                          pickupDateToController.text =
                                              dateFormat.format(
                                                  Global.lotForm.pickupDateTo);
                                        },
                                        currentTime:
                                            Global.lotForm.pickupDateTo == null
                                                ? DateTime.now()
                                                : Global.lotForm.pickupDateTo,
                                        locale: LocaleType.fr,
                                      );
                                    },
                                    style: AppStyles.blackTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.safeBlockVertical * 2),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Quantité en m3',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.darkColor,
                                        fontWeight: FontWeight.w500),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.redColor)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.whiteColor,
                                    border: Border.all(
                                        color: AppColors.lightBlueColor)),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8)),
                                          color: Colors.white),
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: AppColors.greyColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (Global.lotForm.quantity > 0) {
                                                Global.lotForm.quantity -= 1;
                                              }
                                              if (Global.lotForm.quantity !=
                                                  0) {
                                                checkquantity = false;
                                              }
                                            });
                                          }),
                                    ),
                                    Container(
                                      width: 50,
                                      child: Center(
                                          child: Text(
                                              '${Global.lotForm.quantity}')),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: AppColors.greyColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Global.lotForm.quantity += 1;
                                              if (Global.lotForm.quantity !=
                                                  0) {
                                                checkquantity = false;
                                              }
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Visibility(
                            visible: checkquantity,
                            child: Text('Quantity Required',
                                style: TextStyle(
                                    color: AppColors.redColor, fontSize: 12)),
                          ),

                          ///BottomButton
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 4),
                            child: Container(
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
                                  child: Text('Suivant',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  color: AppColors.primaryColor,
                                  textColor: Colors.white,
                                  onPressed: goToNext,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pickupDateFromController.dispose();
    pickupDateToController.dispose();
    super.dispose();
  }
}
