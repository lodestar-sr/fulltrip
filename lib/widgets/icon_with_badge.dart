import 'package:flutter/material.dart';

class IconWithBadge extends StatelessWidget {
  final IconData icon;
  final int badgeCounter;

  IconWithBadge({this.icon, this.badgeCounter});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(width: 32, height: 32),
        Icon(icon),
        badgeCounter > 0
            ? Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 15,
                  height: 15,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$badgeCounter',
                    style: TextStyle(color: Colors.white, fontSize: 9),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
