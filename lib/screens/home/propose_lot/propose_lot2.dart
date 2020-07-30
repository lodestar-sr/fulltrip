import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:Fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:Fulltrip/widgets/google_place_autocomplete/google_place_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProposeLot2 extends StatefulWidget {
  ProposeLot2({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposeLot2State();
}

class _ProposeLot2State extends State<ProposeLot2> {
  final _formKey = GlobalKey<FormState>();
  final deliveryDateFromController = TextEditingController();
  final deliveryDateToController = TextEditingController();
  final dateFormat = DateFormat('MM/dd/yyyy');

  bool selectedDelivery = false;

  @override
  void initState() {
    super.initState();
    deliveryDateFromController.text = Global.lotForm.deliveryDateFrom != null
        ? dateFormat.format(Global.lotForm.deliveryDateFrom)
        : '';
    deliveryDateToController.text = Global.lotForm.deliveryDateTo != null
        ? dateFormat.format(Global.lotForm.deliveryDateTo)
        : '';
  }

  goToNext() {
    //&& Global.lotForm.delivery != ''
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushNamed('ProposeLot3');
    } else if (Global.lotForm.delivery == '') {
      setState(() {
        selectedDelivery = true;
      });
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
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Center(
                  child: Container(
                    child: Text('Précédent',
                        style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                  ),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              new Text("A l'arrivée",
                  style: TextStyle(fontSize: 17, color: AppColors.darkColor)),
              GestureDetector(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Text('Fermer',
                        style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                  ),
                ),
                onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    'dashboard', (Route<dynamic> route) => false),
              )
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                              text: "Adresse d'arrivée",
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.lightGreyColor
                                      .withOpacity(0.6)),
                            ),
                            child: GooglePlacesAutocomplete(
                              initialValue: Global.lotForm.arrivalAddress,
                              underline: InputBorder.none,
                              validator: (value) => Validators.required(value,
                                  errorText: 'Adresse d\'arrivée est requis'),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 13, 26, 13),
                                child: Icon(Feather.map_pin,
                                    size: 16, color: AppColors.redColor),
                              ),
                              onSelect: (val) => this.setState(
                                  () => Global.lotForm.arrivalAddress = val),
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.lightGreyColor
                                      .withOpacity(0.6)),
                            ),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: Global.typedelieu.map((itm) {
                                return DropdownMenuItem(
                                  value: itm,
                                  child: Text(
                                    itm,
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              validator: (value) => Validators.required(value,
                                  errorText: 'Type de lieu est requis'),
                              value: Global.lotForm.arrivalLocationType != ''
                                  ? Global.lotForm.arrivalLocationType
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  Global.lotForm.arrivalLocationType = val;
                                });
                              },
                              decoration: hintTextDecoration('Choisissez ')
                                  .copyWith(border: InputBorder.none),
                              onSaved: (val) => setState(() =>
                                  Global.lotForm.arrivalLocationType = val),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.primaryColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: 'Plein pieds',
                                        groupValue: selectedRadio,
                                        onChanged: (value) {
                                          setState(() {
                                            print(value);
                                            setSelectedRadio(value);
                                          });
                                        },
                                      ),
                                      Text(
                                        'Plein pieds',
                                        style: AppStyles.blackTextStyle
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: selectedRadio ==
                                                        'Plein pieds'
                                                    ? AppColors.primaryColor
                                                    : Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.primaryColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: 'Ascenseur',
                                        groupValue: selectedRadio,
                                        onChanged: (value) {
                                          setState(() {
                                            print(value);
                                            setSelectedRadio(value);
                                          });
                                        },
                                      ),
                                      Text(
                                        'Ascenseur',
                                        style: AppStyles.blackTextStyle
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    selectedRadio == 'Ascenseur'
                                                        ? AppColors.primaryColor
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
                                            MaterialTapTargetSize.shrinkWrap,
                                        activeColor: AppColors.primaryColor,
                                        value: 'Escaliers',
                                        groupValue: selectedRadio,
                                        onChanged: (value) {
                                          setState(() {
                                            print(value);
                                            setSelectedRadio(value);
                                          });
                                        },
                                      ),
                                      Text(
                                        'Escaliers',
                                        style: AppStyles.blackTextStyle
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    selectedRadio == 'Escaliers'
                                                        ? AppColors.primaryColor
                                                        : Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.lightGreyColor
                                      .withOpacity(0.6)),
                            ),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: Global.etages.map((itm) {
                                return DropdownMenuItem(
                                  value: itm,
                                  child: Text(
                                    itm,
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              value: Global.lotForm.arrivalFloors != ''
                                  ? Global.lotForm.arrivalFloors
                                  : null,
                              validator: (value) => Validators.required(value,
                                  errorText: 'Etages est requis'),
                              onChanged: (val) {
                                setState(() {
                                  Global.lotForm.arrivalFloors = val;
                                });
                              },
                              decoration: hintTextDecoration('Choisissez ')
                                  .copyWith(border: InputBorder.none),
                              onSaved: (val) => setState(
                                  () => Global.lotForm.arrivalFloors = val),
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
                                  value: Global.lotForm.arrivalFurnitureLift ==
                                      'Oui',
                                  onChanged: (bool value) {
                                    setState(() {
                                      Global.lotForm.arrivalFurnitureLift =
                                          value ? 'Oui' : 'Non';
                                    });
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
                                'Remontage des meubles ?',
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
                                  setState(() {
                                    Global.lotForm
                                            .startingDismantlingFurniture =
                                        value ? 'Oui' : 'Non';
                                  });
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
                              'PPériode de livraison',
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColors.lightGreyColor
                                            .withOpacity(0.6)),
                                  ),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: deliveryDateFromController,
                                    decoration: hintTextDecoration('entre le')
                                        .copyWith(
                                            prefixIcon: Icon(
                                                MaterialCommunityIcons
                                                    .calendar_range),
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
                                          setState(() => Global
                                              .lotForm.deliveryDateFrom = date);
                                          deliveryDateFromController.text =
                                              dateFormat.format(Global
                                                  .lotForm.deliveryDateFrom);
                                        },
                                        currentTime: Global
                                                    .lotForm.deliveryDateFrom ==
                                                null
                                            ? DateTime.now()
                                            : Global.lotForm.deliveryDateFrom,
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColors.lightGreyColor
                                            .withOpacity(0.6)),
                                  ),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: deliveryDateToController,
                                    decoration: hintTextDecoration('et le')
                                        .copyWith(
                                            prefixIcon: Icon(
                                                MaterialCommunityIcons
                                                    .calendar_range),
                                            border: InputBorder.none),
                                    onTap: () {
                                      DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        minTime: Global
                                                    .lotForm.deliveryDateFrom ==
                                                null
                                            ? DateTime.now()
                                            : Global.lotForm.deliveryDateFrom,
                                        maxTime:
                                            (Global.lotForm.deliveryDateFrom ==
                                                        null
                                                    ? DateTime.now()
                                                    : Global.lotForm
                                                        .deliveryDateFrom)
                                                .add(
                                          Duration(days: 90),
                                        ),
                                        onConfirm: (date) {
                                          setState(() => Global
                                              .lotForm.deliveryDateTo = date);
                                          deliveryDateToController.text =
                                              dateFormat.format(Global
                                                  .lotForm.deliveryDateTo);
                                        },
                                        currentTime:
                                            Global.lotForm.deliveryDateTo ==
                                                    null
                                                ? DateTime.now()
                                                : Global.lotForm.deliveryDateTo,
                                        locale: LocaleType.fr,
                                      );
                                    },
                                    style: AppStyles.blackTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       top: SizeConfig.safeBlockVertical * 2),
                          //   child: RichText(
                          //     text: TextSpan(
                          //       text: 'Prestation',
                          //       style: TextStyle(
                          //           fontSize: 15,
                          //           color: AppColors.darkColor,
                          //           fontWeight: FontWeight.w500),
                          //       children: <TextSpan>[
                          //         TextSpan(
                          //             text: ' *',
                          //             style: TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //                 color: AppColors.redColor)),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 5),
                          //   child: Text(
                          //     '''Lorem ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
                          //     style: TextStyle(
                          //         color: AppColors.greyColor, fontSize: 12),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Material(
                          //         child: new InkWell(
                          //           onTap: () {
                          //             setState(() {
                          //               selectedDelivery = false;
                          //               Global.lotForm.delivery = 'Economique';
                          //             });
                          //           },
                          //           child: new Container(
                          //             padding: EdgeInsets.only(
                          //                 left: 15,
                          //                 right: 15,
                          //                 top: 20,
                          //                 bottom: 20),
                          //             decoration: BoxDecoration(
                          //                 color: Global.lotForm.delivery ==
                          //                         'Economique'
                          //                     ? AppColors.whiteColor
                          //                     : Colors.white,
                          //                 borderRadius:
                          //                     BorderRadius.circular(5),
                          //                 border: Border.all(
                          //                     color: Global.lotForm.delivery ==
                          //                             'Economique'
                          //                         ? AppColors.whiteColor
                          //                         : AppColors.lightGreyColor)),
                          //             child: Center(
                          //                 child: Text(
                          //               'Economique',
                          //               style: TextStyle(
                          //                   fontWeight: FontWeight.w500,
                          //                   color: Global.lotForm.delivery ==
                          //                           'Economique'
                          //                       ? AppColors.primaryColor
                          //                       : AppColors.mediumGreyColor),
                          //             )),
                          //           ),
                          //         ),
                          //         color: Colors.transparent,
                          //       ),
                          //       Material(
                          //         child: new InkWell(
                          //           onTap: () {
                          //             setState(() {
                          //               selectedDelivery = false;
                          //               Global.lotForm.delivery = 'Standard';
                          //             });
                          //           },
                          //           child: new Container(
                          //             padding: EdgeInsets.only(
                          //                 left: 15,
                          //                 right: 15,
                          //                 top: 20,
                          //                 bottom: 20),
                          //             decoration: BoxDecoration(
                          //                 color: Global.lotForm.delivery ==
                          //                         'Standard'
                          //                     ? AppColors.whiteColor
                          //                     : Colors.white,
                          //                 borderRadius:
                          //                     BorderRadius.circular(5),
                          //                 border: Border.all(
                          //                     color: Global.lotForm.delivery ==
                          //                             'Standard'
                          //                         ? AppColors.whiteColor
                          //                         : AppColors.lightGreyColor)),
                          //             child: Center(
                          //                 child: Text(
                          //               'Standard',
                          //               style: TextStyle(
                          //                   fontWeight: FontWeight.w500,
                          //                   color: Global.lotForm.delivery ==
                          //                           'Standard'
                          //                       ? AppColors.primaryColor
                          //                       : AppColors.mediumGreyColor),
                          //             )),
                          //           ),
                          //         ),
                          //         color: Colors.transparent,
                          //       ),
                          //       Material(
                          //         child: new InkWell(
                          //           onTap: () {
                          //             setState(() {
                          //               selectedDelivery = false;
                          //               Global.lotForm.delivery = 'Luxe';
                          //             });
                          //           },
                          //           child: new Container(
                          //             padding: EdgeInsets.only(
                          //                 left: 15,
                          //                 right: 15,
                          //                 top: 20,
                          //                 bottom: 20),
                          //             decoration: BoxDecoration(
                          //                 color:
                          //                     Global.lotForm.delivery == 'Luxe'
                          //                         ? AppColors.whiteColor
                          //                         : Colors.white,
                          //                 borderRadius:
                          //                     BorderRadius.circular(5),
                          //                 border: Border.all(
                          //                     color: Global.lotForm.delivery ==
                          //                             'Luxe'
                          //                         ? AppColors.whiteColor
                          //                         : AppColors.lightGreyColor)),
                          //             child: Center(
                          //                 child: Text(
                          //               'Luxe',
                          //               style: TextStyle(
                          //                   fontWeight: FontWeight.w500,
                          //                   color: Global.lotForm.delivery ==
                          //                           'Luxe'
                          //                       ? AppColors.primaryColor
                          //                       : AppColors.mediumGreyColor),
                          //             )),
                          //           ),
                          //         ),
                          //         color: Colors.transparent,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Visibility(
                          //   visible: selectedDelivery,
                          //   child: Text('le type de livraison est requis',
                          //       style: TextStyle(
                          //           color: AppColors.redColor, fontSize: 12)),
                          // ),

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
    deliveryDateFromController.dispose();
    deliveryDateToController.dispose();
    super.dispose();
  }
}
