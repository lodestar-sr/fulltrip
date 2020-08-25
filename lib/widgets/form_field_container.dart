import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BoxDecoration decoration;

  //passing props in react style
  FormFieldContainer({
    Key key,
    this.child,
    this.decoration,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.only(top: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: this.child,
    );
  }
}
