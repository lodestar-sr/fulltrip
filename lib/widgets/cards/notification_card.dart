import 'package:Fulltrip/data/models/notification.model.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart' hide Notification;

class NotificationCard extends StatelessWidget {
  final Notification notification;
  final Function onPressed;

  NotificationCard({this.notification, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.chatIconColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'W',
                  style: AppStyles.blackTextStyle.copyWith(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.senderCompanyName,
                        style: AppStyles.blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        notification.formatTimestamp(),
                        style: AppStyles.notificationTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      notification.text,
                      style: AppStyles.notificationTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
