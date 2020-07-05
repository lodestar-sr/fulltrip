import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/util/SizeConfig.dart';
import 'package:fulltrip/util/UserCurretnLocation.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/util/validators/validators.dart';
import 'package:fulltrip/widgets/description_text/description_text.dart';
import 'package:fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProposeLot extends StatefulWidget {
  ProposeLot({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposeLotState();
}

class _ProposeLotState extends State<ProposeLot> {
  Map lot = {
    'company': 'Nom de la compagnie',
    'photo':
        'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
    'price': 700,
    'volume': 53,
    'startAddress': 'Paris, France',
    'arrivalAddress': 'Vienne, Autriche',
    'service': 'Luxe',
    'date': '12/12/1222',
    'distance': 1236,
    'period': '12 h. 13 min.',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip',
  };
  List<String> typedelieu = [
    'Immeuble',
    'Maison',
    'Garde-meubles',
    'Entrepôt',
    'Magasin'
  ];
  List<String> typedeacces = ['Plein', 'pieds', 'Ascenseur', 'Escaliers'];
  List<String> etages = [
    'RDC',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  int counter = 0;
  TextEditingController addresfield = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String starting_location_type = '';
  String starting_floors = '';
  bool starting_furniture_lift = false;
  bool starting_dismantling_furniture = false;
  Location location = new Location();
  bool _serviceEnabled;
  bool checkquantity = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.greenColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          title: new Text('Au départ',
              style: TextStyle(fontSize: 17, color: AppColors.darkColor)),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Text('Précédent',
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
                  child: Text('Fermer',
                      style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                ),
              ),
              onTap: () => {},
            )
          ],
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
                            padding: EdgeInsets.all(4),
                            child: TextFormField(
                              controller: addresfield,
                              decoration:
                                  hintTextDecoration("Entrez s'il vous plait")
                                      .copyWith(
                                prefixIcon: Icon(Entypo.location_pin,
                                    color: AppColors.greyColor),
                              ),
                              validator: (value) => Validators.required(value,
                                  errorText:
                                      'Veuillez saisir votre mot de passe'),
                              keyboardType: TextInputType.emailAddress,
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
                                      print(Global.address);
                                      addresfield.text = Global.address;
                                    });
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_searching,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Utilise ma location',
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )
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
                            padding: EdgeInsets.only(left: 20),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: typedelieu.map((itm) {
                                return DropdownMenuItem(
                                  value: itm,
                                  child: Text(
                                    itm,
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              onChanged: (val) {
                                setState(() {
                                  starting_location_type = val;
                                });
                              },
                              decoration: hintTextDecoration('Choisissez '),
                              onSaved: (val) =>
                                  setState(() => starting_location_type = val),
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
                            padding: EdgeInsets.only(left: 20),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: typedeacces.map((itm) {
                                return DropdownMenuItem(
                                  value: itm,
                                  child: Text(
                                    itm,
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              onChanged: (val) {
                                setState(() {
                                  starting_location_type = val;
                                });
                              },
                              decoration: hintTextDecoration('Choisissez '),
                              onSaved: (val) =>
                                  setState(() => starting_location_type = val),
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
                            padding: EdgeInsets.only(left: 20),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              items: etages.map((itm) {
                                return DropdownMenuItem(
                                  value: itm,
                                  child: Text(
                                    itm,
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              //value: starting_location_type,
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              onChanged: (val) {
                                setState(() {
                                  starting_location_type = val;
                                });
                              },
                              decoration: hintTextDecoration('Choisissez '),
                              onSaved: (val) =>
                                  setState(() => starting_location_type = val),
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
                                  value: starting_furniture_lift,
                                  onChanged: (bool value) {
                                    setState(() {
                                      starting_furniture_lift = value;
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
                                'Démontage des meubles ?',
                                style: TextStyle(
                                    color: AppColors.darkGreyColor,
                                    fontSize: 14),
                              ),
                              CupertinoSwitch(
                                value: starting_dismantling_furniture,
                                activeColor: AppColors.primaryColor,
                                onChanged: (bool value) {
                                  setState(() {
                                    starting_dismantling_furniture = value;
                                  });
                                },
                              )
                            ],
                          ),

                          Divider(
                            color: Color(0xffE4E4E4),
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
                                              if (counter > 0) {
                                                counter -= 1;
                                              }
                                            });
                                          }),
                                    ),
                                    Container(
                                      width: 50,
                                      child: Center(child: Text('$counter')),
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
                                              counter += 1;
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
                              child: Text(
                                'Quantity Required',
                                style: TextStyle(
                                    color: AppColors.redColor, fontSize: 12),
                              )),

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
                                  onPressed: () {
                                    if (_formKey.currentState.validate() ||
                                        counter != 0) {
                                      setState(() {
                                        checkquantity = false;
                                      });
                                    } else if (counter == 0) {
                                      setState(() {
                                        checkquantity = !checkquantity;
                                      });
                                    }
                                  },
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
}
