import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';

class AcceptButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AcceptButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.24),
              blurRadius: 16,
              spreadRadius: 4),
        ],
      ),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 60,
        child: FlatButton(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          color: AppColors.primaryColor,
          textColor: Colors.white,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
