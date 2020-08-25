import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/util/constants.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/user_current_location.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:Fulltrip/widgets/google_place_autocomplete.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ProposeLot extends StatefulWidget {
  final onBack;

  ProposeLot({
    Key key,
    this.onBack,
  }) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    Global.isLoading = false;

    final user = context.read<AuthProvider>().loggedInUser;
    Global.lotForm = Lot(
      proposedBy: user.uid,
      proposedCompanyName: user.raisonSociale,
    );

    pickupDateFromController.text = Global.lotForm.pickupDateFrom != null
        ? dateFormat.format(Global.lotForm.pickupDateFrom)
        : '';
    pickupDateToController.text = Global.lotForm.pickupDateTo != null
        ? dateFormat.format(Global.lotForm.pickupDateTo)
        : '';
  }

  goToNext() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushNamed('ProposeLot2');
    }
  }

  String selectedRadio = '';

  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
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
                onTap: () => widget.onBack(),
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
                onTap: () => widget.onBack(),
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
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Adresse de départ',
                              style: AppStyles.blackTextStyle
                                  .copyWith(fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.redColor)),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Icon(
                                    MaterialCommunityIcons.circle_slice_8,
                                    size: 20,
                                    color: AppColors.primaryColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: GooglePlacesAutocomplete(
                                  initialValue: Global.lotForm.startingAddress,
                                  validator: (value) => Validators.required(
                                    value,
                                    errorText: 'Adresse de départ est requis',
                                  ),
                                  onSelect: (val) async {
                                    this.setState(() =>
                                        Global.lotForm.startingAddress = val);
                                    await Global.lotForm
                                        .setCityFromStartingAddress();
                                  },
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  child: Image.asset(
                                    'assets/images/location.png',
                                    height: 25,
                                    width: 25,
                                  ),
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
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: RichText(
                              text: TextSpan(
                                text: 'Type de lieu',
                                style: AppStyles.blackTextStyle
                                    .copyWith(fontWeight: FontWeight.w500),
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
                          DropdownButtonFormField(
                            isExpanded: true,
                            items: Constants.typedelieu.map((itm) {
                              return DropdownMenuItem(
                                  value: itm,
                                  child: Text(itm,
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)));
                            }).toList(),
                            validator: (value) => Validators.required(value,
                                errorText: 'Type de lieu est requis'),
                            onChanged: (val) {
                              setState(() =>
                                  Global.lotForm.startingLocationType = val);
                            },
                            value: Global.lotForm.startingLocationType != ''
                                ? Global.lotForm.startingLocationType
                                : null,
                            decoration: hintTextDecoration('Choisissez'),
                            onSaved: (val) => setState(() =>
                                Global.lotForm.startingLocationType = val),
                          ),
                          Global.lotForm.startingLocationType == 'Immeuble'
                              ? Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Type d'accès",
                                      style: AppStyles.blackTextStyle.copyWith(
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
                                )
                              : Container(),
                          Global.lotForm.startingLocationType == 'Immeuble'
                              ? Container(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Radio(
                                              activeColor:
                                                  AppColors.primaryColor,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              value: 'Plein pieds',
                                              groupValue: selectedRadio,
                                              onChanged: (value) {
                                                setState(() {
                                                  setSelectedRadio(value);
                                                  Global.lotForm
                                                          .startingAccessType =
                                                      value;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Plein pieds',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: selectedRadio ==
                                                              'Plein pieds'
                                                          ? AppColors
                                                              .primaryColor
                                                          : Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Radio(
                                              activeColor:
                                                  AppColors.primaryColor,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              value: 'Ascenseur',
                                              groupValue: selectedRadio,
                                              onChanged: (value) {
                                                setState(() {
                                                  setSelectedRadio(value);
                                                  Global.lotForm
                                                          .startingAccessType =
                                                      value;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Ascenseur',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: selectedRadio ==
                                                              'Ascenseur'
                                                          ? AppColors
                                                              .primaryColor
                                                          : Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Radio(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              activeColor:
                                                  AppColors.primaryColor,
                                              value: 'Escaliers',
                                              groupValue: selectedRadio,
                                              onChanged: (value) {
                                                setState(() {
                                                  setSelectedRadio(value);
                                                  Global.lotForm
                                                          .startingAccessType =
                                                      value;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Escaliers',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: selectedRadio ==
                                                              'Escaliers'
                                                          ? AppColors
                                                              .primaryColor
                                                          : Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),

                          Global.lotForm.startingLocationType == 'Immeuble'
                              ? Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Etages',
                                      style: AppStyles.blackTextStyle.copyWith(
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
                                )
                              : Container(),
                          Global.lotForm.startingLocationType == 'Immeuble'
                              ? DropdownButtonFormField(
                                  isExpanded: true,

                                  items: Constants.etages.map((itm) {
                                    return DropdownMenuItem(
                                        value: itm,
                                        child: Text(itm,
                                            style: AppStyles.blackTextStyle
                                                .copyWith(fontSize: 14)));
                                  }).toList(),
                                  //value: starting_location_type,
                                  validator: (value) => Validators.required(
                                      value,
                                      errorText: 'Etages est requis'),
                                  onChanged: (val) {
                                    setState(() {
                                      Global.lotForm.startingFloors = val;
                                    });
                                  },
                                  value: Global.lotForm.startingFloors != ''
                                      ? Global.lotForm.startingFloors
                                      : null,
                                  decoration: hintTextDecoration('Choisissez '),
                                  onSaved: (val) => setState(() =>
                                      Global.lotForm.startingFloors = val),
                                )
                              : Container(),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Container(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Volume en m³',
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontWeight: FontWeight.w500),
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
                          ),
                          Container(
                            width: 150,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration:
                                  hintTextDecoration('Entrez le volume'),
                              validator: (value) => Validators.required(value,
                                  errorText: 'Veuillez saisir le volume'),
                              onChanged: (value) => setState(() =>
                                  Global.lotForm.quantity = int.parse(value)),
                              onSaved: (value) => setState(() =>
                                  Global.lotForm.quantity = int.parse(value)),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical * 4),
                            child: Text(
                              'Période d\'enlèvement',
                              style: AppStyles.blackTextStyle
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        MaterialCommunityIcons.calendar_range,
                                        color: AppColors.backButtonColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          readOnly: true,
                                          controller: pickupDateFromController,
                                          decoration:
                                              hintTextDecoration('entre le')
                                                  .copyWith(),
                                          onTap: () {
                                            DatePicker.showDatePicker(
                                              context,
                                              showTitleActions: true,
                                              minTime: DateTime.now(),
                                              maxTime: DateTime.now().add(
                                                Duration(days: 90),
                                              ),
                                              onConfirm: (date) {
                                                setState(() => Global.lotForm
                                                    .pickupDateFrom = date);
                                                pickupDateFromController.text =
                                                    dateFormat.format(Global
                                                        .lotForm
                                                        .pickupDateFrom);
                                              },
                                              currentTime: Global.lotForm
                                                          .pickupDateFrom ==
                                                      null
                                                  ? DateTime.now()
                                                  : Global
                                                      .lotForm.pickupDateFrom,
                                              locale: LocaleType.fr,
                                            );
                                          },
                                          style: AppStyles.blackTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: pickupDateToController,
                                      decoration: hintTextDecoration('et le'),
                                      onTap: () {
                                        DatePicker.showDatePicker(
                                          context,
                                          showTitleActions: true,
                                          minTime: Global
                                                      .lotForm.pickupDateFrom ==
                                                  null
                                              ? DateTime.now()
                                              : Global.lotForm.pickupDateFrom,
                                          maxTime:
                                              (Global.lotForm.pickupDateFrom ==
                                                          null
                                                      ? DateTime.now()
                                                      : Global.lotForm
                                                          .pickupDateFrom)
                                                  .add(
                                            Duration(days: 90),
                                          ),
                                          onConfirm: (date) {
                                            setState(() => Global
                                                .lotForm.pickupDateTo = date);
                                            pickupDateToController.text =
                                                dateFormat.format(Global
                                                    .lotForm.pickupDateTo);
                                          },
                                          currentTime:
                                              Global.lotForm.pickupDateTo ==
                                                      null
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
                          ),
                          Global.lotForm.startingLocationType == 'Immeuble' &&
                                  Global.lotForm.startingFloors != 'RDC'
                              ? Container(
                                  margin: EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Monte meuble nécessaire',
                                        style: AppStyles.blackTextStyle
                                            .copyWith(fontSize: 14),
                                      ),
                                      CupertinoSwitch(
                                        activeColor: AppColors.primaryColor,
                                        value: Global.lotForm
                                                .startingFurnitureLift ==
                                            'Oui',
                                        onChanged: (bool value) {
                                          setState(() => Global.lotForm
                                                  .startingFurnitureLift =
                                              value ? 'Oui' : 'Non');
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Démontage des meubles ?',
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontSize: 14),
                                ),
                                CupertinoSwitch(
                                  value: Global.lotForm
                                          .startingDismantlingFurniture ==
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
                                    borderRadius: BorderRadius.circular(10),
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
