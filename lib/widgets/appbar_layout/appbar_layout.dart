import 'package:flutter/material.dart';
import 'package:fulltrip/data/models/hex_color.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';

class AppBarLayout extends AppBar {
  final String appBarTitle;
  final BuildContext context;
  final VoidCallback onBack;

  AppBarLayout({Key key, this.appBarTitle, this.context, this.onBack})
      : super(
    key: key,
    title: new Text(appBarTitle, style: TextStyle(fontSize: 20, color: Colors.white)),
    backgroundColor: AppColors.primaryColor,
    centerTitle: true,
    leading: onBack != null ? IconButton(
      icon: Icon(Icons.navigate_before, color: AppColors.primaryColor),
      onPressed: onBack,
    ) : null,
    automaticallyImplyLeading: false,
    actions: <Widget>[],
  );
}
