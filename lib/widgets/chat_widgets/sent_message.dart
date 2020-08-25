import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';

class SentMessage extends StatelessWidget {
  final String content;

  const SentMessage({
    Key key,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
            right: 8.0, left: 50.0, top: 4.0, bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          child: Container(
            color: AppColors.senderchatColor,
            // margin: const EdgeInsets.only(left: 10.0),
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right: 12.0, left: 15.0, top: 15.0, bottom: 20.0),
                child: Text(
                  content,
                  style: AppStyles.blackTextStyle
                      .copyWith(fontSize: 14, color: Colors.white),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
