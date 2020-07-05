import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/util/SizeConfig.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:fulltrip/widgets/google_place_autocomplete/google_place_autocomplete.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fulltrip/util/validators/validators.dart';

class ProposeLot2 extends StatefulWidget {
  ProposeLot2({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposeLot2State();
}

class _ProposeLot2State extends State<ProposeLot2> {
  int counter = 0;
  String arrival_location_type = '';
  final _formKey = GlobalKey<FormState>();
  String starting_location_type = '';
  String starting_floors = '';
  bool arrival_furniture_lift = false;
  bool arrival_reassembly_furniture = false;
  Location location = new Location();
  bool economique = true;
  bool standard = false;
  bool luxe = false;
  String selectedDelivery = 'Economique';

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
                onTap: () => {},
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
                      padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
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
                            padding: EdgeInsets.only(right: 16),
                            child: GooglePlacesAutocomplete(
                              //initialValue: '',
                              validator: (value) => Validators.required(value,
                                  errorText:
                                      'Veuillez saisir votre mot de passe'),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Image.asset(
                                  'assets/images/locationArrival.png',
                                  width: 16,
                                  height: 16,
                                ),
                              ),
                              onSelect: (val) => this
                                  .setState(() => arrival_location_type = val),
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
                                  value: arrival_furniture_lift,
                                  onChanged: (bool value) {
                                    setState(() {
                                      arrival_furniture_lift = value;
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
                                value: arrival_reassembly_furniture,
                                activeColor: AppColors.primaryColor,
                                onChanged: (bool value) {
                                  setState(() {
                                    arrival_reassembly_furniture = value;
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
                            child: RichText(
                              text: TextSpan(
                                text: 'Prestation',
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
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '''Lorem ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
                              style: TextStyle(
                                  color: AppColors.greyColor, fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Material(
                                  child: new InkWell(
                                    onTap: () {
                                      print("tapped");
                                      setState(() {
                                        economique = !economique;
                                        standard = false;
                                        luxe = false;
                                        selectedDelivery = 'Economique';
                                      });
                                    },
                                    child: new Container(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 20,
                                          bottom: 20),
                                      decoration: BoxDecoration(
                                          color: economique
                                              ? AppColors.whiteColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: economique
                                                  ? AppColors.whiteColor
                                                  : AppColors.lightGreyColor)),
                                      child: Center(
                                          child: Text(
                                        'Economique',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: economique
                                                ? AppColors.primaryColor
                                                : AppColors.mediumGreyColor),
                                      )),
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
                                Material(
                                  child: new InkWell(
                                    onTap: () {
                                      print("tapped");
                                      setState(() {
                                        standard = !standard;
                                        economique = false;
                                        luxe = false;
                                        selectedDelivery = 'Standard';
                                      });
                                    },
                                    child: new Container(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 20,
                                          bottom: 20),
                                      decoration: BoxDecoration(
                                          color: standard
                                              ? AppColors.whiteColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: standard
                                                  ? AppColors.whiteColor
                                                  : AppColors.lightGreyColor)),
                                      child: Center(
                                          child: Text(
                                        'Standard',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: standard
                                                ? AppColors.primaryColor
                                                : AppColors.mediumGreyColor),
                                      )),
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
                                Material(
                                  child: new InkWell(
                                    onTap: () {
                                      print("tapped");
                                      setState(() {
                                        luxe = !luxe;
                                        economique = false;
                                        standard = false;
                                        selectedDelivery = 'Luxe';
                                      });
                                    },
                                    child: new Container(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 20,
                                          bottom: 20),
                                      decoration: BoxDecoration(
                                          color: luxe
                                              ? AppColors.whiteColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: luxe
                                                  ? AppColors.whiteColor
                                                  : AppColors.lightGreyColor)),
                                      child: Center(
                                          child: Text(
                                        'Luxe',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: luxe
                                                ? AppColors.primaryColor
                                                : AppColors.mediumGreyColor),
                                      )),
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
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
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Navigator.of(context)
                                          .pushNamed('ProposeLot3');
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
