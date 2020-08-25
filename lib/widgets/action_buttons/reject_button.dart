import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';

class RejectButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  RejectButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Text(
          text,
          style: AppStyles.declineActionTextStyle,
        ),
      ),
      onTap: onPressed,
    );
  }
}
