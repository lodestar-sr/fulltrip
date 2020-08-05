import 'package:Fulltrip/data/models/DistanceTimeModel.dart';
import 'package:Fulltrip/data/models/lot.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProposeLot4 extends StatefulWidget {
  ProposeLot4({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposeLot4State();
}

class _ProposeLot4State extends State<ProposeLot4> {
  var myFormat = DateFormat('d/MM');
  Lot lot;
  var startingaddress = [];
  var arrivaladdress = [];
  double distanceinKm = 0.0;
  String time = '';
  Future<DistanceTimeModel> distanceTimeModel;

  @override
  void initState() {
    super.initState();

    setState(() {
      lot = Global.lotForm;
      startingaddress = lot.startingAddress.split(',');
      arrivaladdress = lot.arrivalAddress.split(',');
    });

    setState(() => Global.isLoading = true);
    Global.calculateDistance(
            startingAddress: lot.startingAddress,
            arrivalAddress: lot.arrivalAddress)
        .then((value) {
      setState(() => Global.isLoading = false);
      if (mounted) {
        setState(() {
          distanceinKm = value['distanceinKm'];
          time = value['duration'];
        });
      }
    });
  }

  onSubmit() async {
    setState(() => Global.isLoading = true);
    Map data = Global.lotForm.toJson();
    await Global.firestore.collection('lots').add(data);
    setState(() => Global.isLoading = false);
    Navigator.of(context).pushNamedAndRemoveUntil(
        'Felicitations', (Route<dynamic> route) => false);
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
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: AppColors.backButtonColor, //change your color here
          ),
          title: Text(
            'Validation',
            style:
                AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
          ),
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
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 146,
                            margin: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              image: lot.photo != ''
                                  ? DecorationImage(
                                      image: NetworkImage(lot.photo),
                                      fit: BoxFit.cover,
                                    )
                                  : DecorationImage(
                                      image: this.lot.photo != ''
                                          ? NetworkImage(lot.photo)
                                          : AssetImage(
                                              "assets/images/noimage.png"),
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16, bottom: 5),
                            child: Row(
                              children: [
                                Icon(MaterialCommunityIcons.calendar_range,
                                    size: 20, color: AppColors.primaryColor),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                      'Publié le ${myFormat.format(lot.date)}',
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 4, right: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                          MaterialCommunityIcons.circle_slice_8,
                                          size: 20,
                                          color: AppColors.primaryColor),
                                      Container(
                                          padding: EdgeInsets.only(top: 2),
                                          width: 9,
                                          child: Dash(
                                            direction: Axis.vertical,
                                            length: 40,
                                            dashLength: 6,
                                            dashThickness: 2,
                                            dashColor: AppColors.greyColor,
                                          )),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 3.0),
                                        child: Text(
                                          lot.startingAddress,
                                          style: AppStyles.blackTextStyle
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      lot.pickupDateFrom != null
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                'du ${myFormat.format(lot.pickupDateFrom)} au ${myFormat.format(lot.pickupDateTo)}',
                                                style: AppStyles.greyTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, top: 5, left: 8),
                            child: Text('$time  ($distanceinKm km)',
                                style: AppStyles.blackTextStyle
                                    .copyWith(fontSize: 12)),
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          width: 9,
                                          child: Dash(
                                            direction: Axis.vertical,
                                            length: 40,
                                            dashLength: 6,
                                            dashThickness: 2,
                                            dashColor: AppColors.greyColor,
                                          )),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Icon(Feather.map_pin,
                                          size: 20, color: AppColors.redColor),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 3.0),
                                        child: Text(
                                          lot.arrivalAddress,
                                          style: AppStyles.blackTextStyle
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      lot.deliveryDateFrom != null
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                'du ${myFormat.format(lot.deliveryDateFrom)} au ${myFormat.format(lot.deliveryDateTo)}',
                                                style: AppStyles.greyTextStyle
                                                    .copyWith(fontSize: 12),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: 8),
                          //   child: Divider(
                          //     color: AppColors.lightGreyColor,
                          //   ),
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: new ExpansionTile(
                              // tilePadding: EdgeInsets.symmetric(horizontal: 70),
                              // expandedCrossAxisAlignment:
                              //     CrossAxisAlignment.start,
//                              expandedAlignment: Alignment.centerLeft,
                              title: new Text("Parcourir les détails",
                                  style: AppStyles.primaryTextStyle
                                      .copyWith(fontWeight: FontWeight.w500)),
                              children: <Widget>[
                                Text(
                                  'Informations',
                                  style: AppStyles.blackTextStyle.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          new Text(
                                            "Au départ",
                                            style: AppStyles.blackTextStyle
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 4, top: 4),
                                            child: Text('Type de lieu',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14)),
                                          ),
                                          Text(
                                              '${lot.startingLocationType.trim()}',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .backButtonColor,
                                                      fontSize: 14)),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            child: Divider(
                                              color: AppColors.lightGreyColor,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 4, top: 4),
                                            child: Text("Type d'accès",
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14)),
                                          ),
                                          Text('${lot.startingAccessType}',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .backButtonColor,
                                                      fontSize: 14)),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            child: Divider(
                                              color: AppColors.lightGreyColor,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 4, top: 4),
                                            child: Text("Etages",
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14)),
                                          ),
                                          Text('${lot.startingFloors}',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .backButtonColor,
                                                      fontSize: 14)),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          new Text(
                                            "À l'arrivée",
                                            style: AppStyles.blackTextStyle
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 4, top: 4),
                                            child: Text(
                                                'Type de lieu                ',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14)),
                                          ),
                                          Text('${lot.startingLocationType}',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .backButtonColor,
                                                      fontSize: 14)),
                                          Container(
                                            child: Divider(
                                              color: AppColors.lightGreyColor,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 4, top: 4),
                                            child: Text("Type d'accès",
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14)),
                                          ),
                                          Text('${lot.startingAccessType}',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .backButtonColor,
                                                      fontSize: 14)),
                                          Container(
                                            child: Divider(
                                              color: AppColors.lightGreyColor,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 4, top: 4),
                                            child: Text("Etages",
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14)),
                                          ),
                                          Text('${lot.startingFloors}',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .backButtonColor,
                                                      fontSize: 14)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Divider(
                                    color: AppColors.lightGreyColor,
                                    thickness: 1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 4, top: 4),
                                          child: Text('Monte meubles',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(fontSize: 14)),
                                        ),
                                        Text('${lot.startingFurnitureLift}',
                                            style: AppStyles.blackTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .backButtonColor,
                                                    fontSize: 14)),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: Divider(
                                            color: AppColors.lightGreyColor,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 4, top: 4),
                                          child: Text('Démontage meubles',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(fontSize: 14)),
                                        ),
                                        Text(
                                            '${lot.startingDismantlingFurniture}',
                                            style: AppStyles.blackTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .backButtonColor,
                                                    fontSize: 14)),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 4, top: 4),
                                          child: Text('Monte meubles',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(fontSize: 14)),
                                        ),
                                        Text('${lot.arrivalFurnitureLift}',
                                            style: AppStyles.blackTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .backButtonColor,
                                                    fontSize: 14)),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: Divider(
                                            color: AppColors.lightGreyColor,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 4, top: 4),
                                          child: Text('Remontage meubles',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(fontSize: 14)),
                                        ),
                                        Text(
                                            '${lot.arrivalReassemblyFurniture}',
                                            style: AppStyles.blackTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .backButtonColor,
                                                    fontSize: 14)),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4, top: 4),
                            child: Text('Volume',
                                style: AppStyles.blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 17)),
                          ),
                          Text('${lot.quantity}m³',
                              style: AppStyles.blackTextStyle.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),

                          Container(
                            margin: EdgeInsets.only(bottom: 4, top: 15),
                            child: Text('Montant à payer',
                                style: AppStyles.blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 17)),
                          ),
                          Text('${lot.price}€',
                              style: AppStyles.blackTextStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),

                          Container(
                            margin: EdgeInsets.only(bottom: 4, top: 15),
                            child: Text('Paiement',
                                style: AppStyles.blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 15)),
                          ),
                          Text('',
                              style: AppStyles.blackTextStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed('MeansOfPayment'),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppColors.primaryColor,
                                  size: 27,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Ajouter un mode de paiement",
                                  style: AppStyles.primaryTextStyle
                                      .copyWith(fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                                  child: Text('Réserver ce lot',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  color: AppColors.primaryColor,
                                  textColor: Colors.white,
                                  onPressed: onSubmit,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "En cas de non prise en charge de votre lot, et sur demande de votre part, l'ensemble des frais engagés peuvent être remboursés sans pénalités",
                            style: AppStyles.blackTextStyle.copyWith(
                                fontSize: 11, color: AppColors.backButtonColor),
                          )
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
