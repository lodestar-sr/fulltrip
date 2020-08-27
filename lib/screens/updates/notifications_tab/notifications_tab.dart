import 'package:Fulltrip/services/lot.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:Fulltrip/services/notification.service.dart';
import 'package:Fulltrip/data/models/notification.model.dart';
import 'package:Fulltrip/widgets/no_data.dart';
import 'package:Fulltrip/widgets/cards/notification_card.dart';
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

  NotificationCard buildStandardNotificationWidget(Notification notification,
      {String bottomText}) {
    return NotificationCard(
      text: notification.text,
      companyName: notification.senderCompanyName,
      onPressed: () async {
        Navigator.of(context).pushNamed(
          'lot-details',
          arguments: {
            'lot': await LotService.getLotByUid(notification.lot),
            'company_name': notification.senderCompanyName,
            'bottom_text': bottomText,
          },
        );
      },
    );
  }

  List<Widget> buildNotificationList() {
    List<Widget> list = [];

    notifications.forEach((notification) async {
      final notificationType = NotificationType.values[notification.type];
      NotificationCard card;

      switch (notificationType) {
        case NotificationType.reservationValidation:
        case NotificationType.refusedReservationValidation:
          card = NotificationCard(
            text: notification.text,
            companyName: notification.senderCompanyName,
            onPressed: () async {
              Navigator.of(context).pushNamed(
                'lot-validation',
                arguments: {
                  'lot': await LotService.getLotByUid(notification.lot),
                  'reserved_user_uid': notification.sender,
                  'reserved_company_name': notification.senderCompanyName,
                },
              );
            },
          );
          break;
        case NotificationType.confirmedReservation:
          card = buildStandardNotificationWidget(
            notification,
            bottomText:
                'Votre réservation a été acceptée, prenez contacte avec votre nouveau collaborateur',
          );
          break;
        case NotificationType.refusedReservation:
          card = buildStandardNotificationWidget(
            notification,
            bottomText: 'Votre réservation a été refusée',
          );
          break;
        case NotificationType.irrelevantReservation:
          card = buildStandardNotificationWidget(
            notification,
            bottomText: 'Un autre transporteur a été sélectionné pour ce lot',
          );
          break;
        case NotificationType.confirmedReservationValidation:
          card = buildStandardNotificationWidget(
            notification,
            bottomText: 'Vous avez confirmé cette réservation',
          );
          break;
        case NotificationType.irrelevantReservationValidation:
          card = buildStandardNotificationWidget(
            notification,
            bottomText:
                'Vous avez sélectionné un autre transporteur pour ce lot',
          );
          break;
      }
      list.add(card);
    });

    if (list.length == 0) {
      list.add(NoData());
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
