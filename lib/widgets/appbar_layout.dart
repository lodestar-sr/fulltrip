import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';

class AppBarLayout extends AppBar {
  final String appBarTitle;
  final BuildContext context;
  final VoidCallback onBack;

  AppBarLayout({Key key, this.appBarTitle, this.context, this.onBack})
      : super(
          key: key,
          title: new Text(appBarTitle, style: TextStyle(fontSize: 18, color: AppColors.darkColor)),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: onBack != null
              ? IconButton(
                  icon: Icon(Icons.navigate_before, color: AppColors.darkColor),
                  onPressed: onBack,
                )
              : null,
          automaticallyImplyLeading: false,
          actions: <Widget>[],
        );
}
