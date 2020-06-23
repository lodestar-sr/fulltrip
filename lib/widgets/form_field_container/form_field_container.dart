import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget child;
  final double bottom;
  final EdgeInsets padding;
  final EdgeInsets margin;

  //passing props in react style
  FormFieldContainer({
    Key key,
    this.child,
    this.bottom = 15,
    this.padding = const EdgeInsets.fromLTRB(21, 4, 21, 4),
    this.margin = const EdgeInsets.only(bottom: 15),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
      ),
      child: this.child,
    );
  }
}
