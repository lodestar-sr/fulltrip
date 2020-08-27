import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';

class ReceivedMessage extends StatelessWidget {
  final String content;

  const ReceivedMessage({
    Key key,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 5.0, left: 8.0, top: 8.0, bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.chatIconColor, shape: BoxShape.circle),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(15)),
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 72,
                    color: AppColors.lightGreyColor.withOpacity(0.3),
                    child: Stack(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15.0, left: 8.0, top: 15.0, bottom: 20.0),
                        child: Text(
                          content,
                          style:
                              AppStyles.blackTextStyle.copyWith(fontSize: 14),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
