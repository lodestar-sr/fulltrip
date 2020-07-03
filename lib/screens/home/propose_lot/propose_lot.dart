import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/widgets/description_text/description_text.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProposeLot extends StatefulWidget {
  ProposeLot({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposeLotState();
}

class _ProposeLotState extends State<ProposeLot> {
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
      color: AppColors.greenColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          title: new Text('Au départ', style: TextStyle(fontSize: 17, color: AppColors.darkColor)),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Text('Précédent', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
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
                  child: Text('Fermer', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                ),
              ),
              onTap: () => {},
            )
          ],
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
                                child: Text('Suivant', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
