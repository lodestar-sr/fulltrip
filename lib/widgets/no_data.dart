import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 48),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
              child: Text(
                'Aucune donnée disponible.',
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 14,
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
