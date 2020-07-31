import 'dart:async';

import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SuccessScreen extends StatefulWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: CircularProgressIndicator(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            'assets/images/check-circle.png',
                            height: 200,
                            width: 200,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'Félicitations!',
                              style: TextStyle(fontSize: 34),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'Le lot a bien été réservé, prenez contact avec votre nouveau collaborateur !',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.greyColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'dashboard',
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                "Page d'accueil",
                                style: AppStyles.primaryTextStyle.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
