import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/util/SizeConfig.dart';
import 'package:fulltrip/util/UserCurretnLocation.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/util/validators/validators.dart';
import 'package:fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fulltrip/widgets/google_place_autocomplete/google_place_autocomplete.dart';

class ProposeLot extends StatefulWidget {
  ProposeLot({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposeLotState();
}

class _ProposeLotState extends State<ProposeLot> {
  int counter = 0;
  String arrivalAddress = '';
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
              new Text('Au départ',
                  style: TextStyle(fontSize: 17, color: AppColors.darkColor)),
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
                            padding: EdgeInsets.only(right: 16),
                            child: GooglePlacesAutocomplete(
                              initialValue: arrivalAddress,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Image.asset(
                                  'assets/images/locationDeparture.png',
                                  width: 16,
                                  height: 16,
                                  color: AppColors.greyColor,
                                ),
                              ),
                              validator: (value) => Validators.required(value,
                                  errorText:
                                      'Veuillez saisir votre mot de passe'),
                              onSelect: (val) =>
                                  this.setState(() => arrivalAddress = val),
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
                                      arrivalAddress = Global.address;
                                      print(arrivalAddress);
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
                              items: Global.typedeacces.map((itm) {
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
                                    if (_formKey.currentState.validate() &&
                                        counter != 0) {
                                      setState(() {
                                        checkquantity = false;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('ProposeLot2');
                                    } else if (counter == 0) {
                                      setState(() {
                                        checkquantity = true;
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
