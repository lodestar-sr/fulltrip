import 'package:flutter/material.dart';

import '../../util/theme.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle buttonTextStyle;
  final String buttonName;

  //passing props in react style
  DefaultButton({
    Key key,
    this.buttonName,
    this.onPressed,
    this.buttonTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      child: new Text(buttonName, textDirection: TextDirection.ltr,
        style: buttonTextStyle ?? TextStyle(color: AppColors.primaryColor, fontSize: 20),
      ),
      color: AppColors.primaryColor,
      onPressed: onPressed,
    );
  }
}
