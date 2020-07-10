import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/widgets/description_text/description_text.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LotDetails extends StatefulWidget {
  LotDetails({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LotDetailsState();
}

class _LotDetailsState extends State<LotDetails> {
  Map lot = {
    'company': 'Nom de la compagnie',
    'photo': 'https://www.fedex.com/content/dam/fedex/us-united-states/FedEx-Office/images/2020/Q3/FED03799_TrackingLPUpdate_ConsumerGroundShipPod_727x463_888131779.jpg',
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

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                            width: double.infinity,
                            height: 146,
                            margin: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              image: DecorationImage(image: NetworkImage(lot['photo']), fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16, bottom: 32),
                            child: Row(
                              children: [
                                Icon(AntDesign.calendar, size: 14, color: AppColors.greyColor),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text('Publié le ${lot['date']}', style: AppStyles.blackTextStyle.copyWith(fontSize: 14)),
                                ),
                              ],
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Entypo.circle, size: 9, color: AppColors.darkGreyColor),
                                      Dash(
                                        direction: Axis.vertical,
                                        length: 48,
                                        dashLength: 3,
                                        dashColor: AppColors.darkGreyColor,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lot['startAddress'],
                                      style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '40 Avenue Leon Blum',
                                      style: AppStyles.greyTextStyle.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 16, top: 16),
                            child: Text('${lot['period']}  (${lot['distance'].toString()} km)', style: AppStyles.blackTextStyle.copyWith(fontSize: 12)),
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
                                      Dash(
                                        direction: Axis.vertical,
                                        length: 48,
                                        dashLength: 3,
                                        dashColor: AppColors.darkGreyColor,
                                      ),
                                      Icon(Entypo.circle, size: 9, color: AppColors.darkGreyColor),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lot['startAddress'],
                                      style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '40 Avenue Leon Blum',
                                      style: AppStyles.greyTextStyle.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Divider(
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text('Prestation', style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
                          ),
                          Text(lot['service'], style: AppStyles.greyTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 18)),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Divider(
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text('La description', style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14)),
                          ),
                          DescriptionText(
                            text: lot['description'],
                            minLength: 140,
                            textStyle: AppStyles.greyTextStyle.copyWith(fontSize: 10, fontWeight: FontWeight.w300, height: 1.3),
                            moreTextStyle: AppStyles.primaryTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 10, height: 1.4),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8, bottom: 4),
                            child: Divider(
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Prix de l\'expédition', style: AppStyles.blackTextStyle.copyWith(fontSize: 18)),
                              Container(
                                margin: EdgeInsets.only(left: 24),
                                child: Text('${lot['price']}€', style: AppStyles.darkGreyTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 24)),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8, top: 4),
                            child: Divider(
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text('NOM DE LA COMPAGNIE', style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8, bottom: 24),
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Icon(Feather.message_square, size: 18, color: AppColors.primaryColor),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text('Contacter l\'entreprise', style: AppStyles.primaryTextStyle.copyWith(fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: AppColors.primaryColor.withOpacity(0.24), blurRadius: 16, spreadRadius: 4),
                              ],
                            ),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              height: 60,
                              child: RaisedButton(
                                child: Text('Réservez cet article', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
