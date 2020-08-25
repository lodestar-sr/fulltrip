import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  //passing props in react style
  AppLoader({
    Key key,
    this.child,
    this.padding = const EdgeInsets.all(8),
    this.margin = const EdgeInsets.only(top: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Image.asset('assets/images/loader.gif', width: 80),
    );
  }
}
