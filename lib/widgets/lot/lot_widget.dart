import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/description_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class LotWidget extends StatelessWidget {
  final Lot lot;
  final String companyName;
  final double distanceInKm;
  final String time;

  LotWidget({this.lot, this.companyName, this.distanceInKm, this.time});

  @override
  Widget build(BuildContext context) {
    final myFormat = DateFormat('d/MM');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          height: 146,
          margin: EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            image: lot.photo != ''
                ? DecorationImage(
                    image: NetworkImage(lot.photo),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: this.lot.photo != ''
                        ? NetworkImage(lot.photo)
                        : AssetImage("assets/images/noimage.png"),
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
                child: Text('Publié le ${myFormat.format(lot.date)}',
                    style: AppStyles.blackTextStyle.copyWith(fontSize: 15)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Divider(),
        ),
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 4, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(MaterialCommunityIcons.circle_slice_8,
                        size: 20, color: AppColors.primaryColor),
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      width: 9,
                      child: Dash(
                        direction: Axis.vertical,
                        length: 40,
                        dashLength: 6,
                        dashThickness: 2,
                        dashColor: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text(
                        lot.startingAddress,
                        style: AppStyles.blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    lot.pickupDateFrom != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              'du ${myFormat.format(lot.pickupDateFrom)} au ${myFormat.format(lot.pickupDateTo)}',
                              style: AppStyles.greyTextStyle.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 13),
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
          child: Text('$time  ($distanceInKm km)',
              style: AppStyles.blackTextStyle.copyWith(fontSize: 12)),
        ),
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Icon(Feather.map_pin, size: 20, color: AppColors.redColor),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text(
                        lot.arrivalAddress,
                        style: AppStyles.blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    lot.deliveryDateFrom != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 5.0),
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
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Divider(
            color: AppColors.lightGreyColor,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0, bottom: 10.0),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text("Parcourir les détails",
                  style: AppStyles.primaryTextStyle
                      .copyWith(fontWeight: FontWeight.w500)),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(
                          "Au départ",
                          style: AppStyles.blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4, top: 4),
                          child: Text('Type de lieu',
                              style: AppStyles.blackTextStyle
                                  .copyWith(fontSize: 14)),
                        ),
                        Text('${lot.startingLocationType.trim()}',
                            style: AppStyles.blackTextStyle.copyWith(
                                color: AppColors.backButtonColor,
                                fontSize: 14)),
                        lot.startingAccessType.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 4, top: 8),
                                child: Text("Type d'accès",
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14)),
                              )
                            : Container(),
                        lot.startingAccessType.isNotEmpty
                            ? Text('${lot.startingAccessType}',
                                style: AppStyles.blackTextStyle.copyWith(
                                    color: AppColors.backButtonColor,
                                    fontSize: 14))
                            : Container(),
                        lot.startingFloors.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 4, top: 8),
                                child: Text("Etages",
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14)),
                              )
                            : Container(),
                        lot.startingFloors.isNotEmpty
                            ? Text('${lot.startingFloors}',
                                style: AppStyles.blackTextStyle.copyWith(
                                    color: AppColors.backButtonColor,
                                    fontSize: 14))
                            : Container(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(
                          "À l'arrivée",
                          style: AppStyles.blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4, top: 4),
                          child: Text('Type de lieu                ',
                              style: AppStyles.blackTextStyle
                                  .copyWith(fontSize: 14)),
                        ),
                        Text('${lot.arrivalLocationType}',
                            style: AppStyles.blackTextStyle.copyWith(
                                color: AppColors.backButtonColor,
                                fontSize: 14)),
                        lot.arrivalAccessType.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 4, top: 8),
                                child: Text("Type d'accès",
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14)),
                              )
                            : Container(),
                        lot.arrivalAccessType.isNotEmpty
                            ? Text('${lot.arrivalAccessType}',
                                style: AppStyles.blackTextStyle.copyWith(
                                    color: AppColors.backButtonColor,
                                    fontSize: 14))
                            : Container(),
                        lot.arrivalFloors.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 4, top: 8),
                                child: Text("Etages",
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14)),
                              )
                            : Container(),
                        lot.arrivalFloors.isNotEmpty
                            ? Text('${lot.arrivalFloors}',
                                style: AppStyles.blackTextStyle.copyWith(
                                    color: AppColors.backButtonColor,
                                    fontSize: 14))
                            : Container(),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Divider(
                    color: AppColors.lightGreyColor,
                    thickness: 1,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          lot.startingFurnitureLift != 'Non'
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: Text('Monte meubles',
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)),
                                )
                              : Container(),
                          lot.startingFurnitureLift != 'Non'
                              ? Text('${lot.startingFurnitureLift}',
                                  style: AppStyles.blackTextStyle.copyWith(
                                      color: AppColors.backButtonColor,
                                      fontSize: 14))
                              : Container(),
                          Container(padding: EdgeInsets.all(4)),
                          lot.startingDismantlingFurniture != 'Non'
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: Text('Démontage meubles',
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)),
                                )
                              : Container(),
                          lot.startingDismantlingFurniture != 'Non'
                              ? Text('${lot.startingDismantlingFurniture}',
                                  style: AppStyles.blackTextStyle.copyWith(
                                      color: AppColors.backButtonColor,
                                      fontSize: 14))
                              : Container(),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          lot.arrivalFurnitureLift != 'Non'
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: Text('Monte meubles',
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)),
                                )
                              : Container(),
                          lot.arrivalFurnitureLift != 'Non'
                              ? Text('${lot.arrivalFurnitureLift}',
                                  style: AppStyles.blackTextStyle.copyWith(
                                      color: AppColors.backButtonColor,
                                      fontSize: 14))
                              : Container(),
                          Container(padding: EdgeInsets.all(4)),
                          lot.arrivalReassemblyFurniture != 'Non'
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: Text('Remontage meubles',
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)),
                                )
                              : Container(),
                          lot.arrivalReassemblyFurniture != 'Non'
                              ? Text('${lot.arrivalReassemblyFurniture}',
                                  style: AppStyles.blackTextStyle.copyWith(
                                      color: AppColors.backButtonColor,
                                      fontSize: 14))
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 4, top: 4),
          child: Text('Volume',
              style: AppStyles.blackTextStyle
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 17)),
        ),
        Text('${lot.quantity}m³',
            style: AppStyles.blackTextStyle
                .copyWith(color: AppColors.primaryColor, fontSize: 18)),
        lot.description.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(bottom: 4, top: 15),
                child: Text('La description',
                    style: AppStyles.blackTextStyle
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 17)),
              )
            : Container(),
        lot.description.isNotEmpty
            ? DescriptionText(
                text: lot.description,
                minLength: 60,
                textStyle: AppStyles.greyTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: AppColors.backButtonColor,
                    height: 1.3),
                moreTextStyle: AppStyles.primaryTextStyle.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 13, height: 1.4),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text('Prix de l\'expédition',
              style: AppStyles.blackTextStyle.copyWith(fontSize: 18)),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            '${lot.price.toStringAsFixed(0)}€',
            style: AppStyles.darkGreyTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
                fontSize: 24),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 25),
          alignment: Alignment.centerLeft,
          child: Text(
            companyName,
            style: AppStyles.blackTextStyle
                .copyWith(fontWeight: FontWeight.w500, fontSize: 17),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 25),
          child: GestureDetector(
            child: Row(
              children: [
                Icon(
                  Feather.message_square,
                  size: 18,
                  color: AppColors.primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Contacter l\'entreprise',
                    style: AppStyles.primaryTextStyle
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
