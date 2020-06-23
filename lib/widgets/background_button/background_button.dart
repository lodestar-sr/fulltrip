import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/util/theme.dart';

class BackgroundButton extends StatelessWidget {

  final Widget child;
  final double width;
  final double height;
  final Function onPressed;
  final double radius;
  final Color color;

  const BackgroundButton({
    Key key,
    @required this.child,
    this.width = double.infinity,
    this.height = 56,
    this.onPressed,
    this.radius = 15,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      minWidth: width,
      child: child,
      height: height,
      color: color ?? AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      onPressed: onPressed,
    );
  }
}