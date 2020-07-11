import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/size_config.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Felicitations extends StatefulWidget {
  Felicitations({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FelicitationsState();
}

class _FelicitationsState extends State<Felicitations> {
  _FelicitationsState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).popAndPushNamed('dashboard');
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
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
                            'Votre lot a été ajouté!',
                            style: TextStyle(fontSize: 13, color: AppColors.greyColor),
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
    );
  }
}
