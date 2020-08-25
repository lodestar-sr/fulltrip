import 'package:Fulltrip/services/lot.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:Fulltrip/services/notification.service.dart';
import 'package:Fulltrip/data/models/notification.model.dart';
import 'package:Fulltrip/widgets/notification_widget.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class NotificationsTab extends StatefulWidget {
  NotificationsTab({Key key}) : super(key: key);

  @override
  _NotificationsTabState createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  List<Notification> notifications = [];

  @override
  void initState() {
    Global.isLoading = true;
    super.initState();
    getNotifications();
  }

  void getNotifications() async {
    final user = context.read<AuthProvider>().loggedInUser;
    notifications = await NotificationService.getNotificationsForUser(user.uid);
    setState(() => Global.isLoading = false);
  }

  List<Widget> buildNotificationList() {
    List<Widget> list = [];
    notifications.forEach((notification) async {
      final notificationType = NotificationType.values[notification.type];

      if (notificationType == NotificationType.newReservation) {
        list.add(
          NotificationWidget(
            text: notification.text,
            companyName: notification.senderCompanyName,
            onPressed: () async {
              Navigator.of(context).pushNamed(
                'lot-validation',
                arguments: {
                  'lot': await LotService.getLotByUid(notification.lot),
                  'sender_uid': notification.sender,
                  'sender_company_name': notification.senderCompanyName,
                },
              );
            },
          ),
        );
      } else if (notificationType == NotificationType.rejectedReservation) {
        list.add(
          NotificationWidget(
            text: notification.text,
            companyName: notification.senderCompanyName,
            onPressed: () async {
              Navigator.of(context).pushNamed(
                'lot-details',
                arguments: {
                  'lot': await LotService.getLotByUid(notification.lot),
                  'company_name': notification.senderCompanyName,
                },
              );
            },
          ),
        );
      }
    });

    if (list.length == 0) {
      list.add(
        Container(
          padding: EdgeInsets.only(left: 32, right: 32, top: 48),
          child: Center(
            child: Text(
              'No data available',
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 14,
                height: 1.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Container(
        height: double.infinity,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: buildNotificationList(),
        ),
      ),
    );
  }
}
