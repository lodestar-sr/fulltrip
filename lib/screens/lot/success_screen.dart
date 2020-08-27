import 'dart:collection';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/action_buttons/accept_button.dart';
import 'package:Fulltrip/widgets/action_buttons/reject_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LinkedHashMap<String, dynamic> args =
        ModalRoute.of(context).settings.arguments;
    final text = args['text'];
    final companyName = args['company_name'];

    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                  text,
                  textAlign: TextAlign.center,
                  style: AppStyles.successScreenTextStyle,
                ),
              ),
              SizedBox(height: companyName != null ? 40 : 15),
              companyName != null
                  ? AcceptButton(
                      text: 'Contacter $companyName',
                      onPressed: () {},
                    )
                  : SizedBox(),
              RejectButton(
                text: 'Aller à la page d\'accueil',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'dashboard', (Route<dynamic> route) => false);
                },
              ),
              SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
