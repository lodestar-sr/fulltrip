import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/util/theme.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  //passing props in react style
  FormFieldContainer({
    Key key,
    this.child,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.only(top: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.lightGreyColor.withOpacity(0.6)),
      ),
      child: this.child,
    );
  }
}
