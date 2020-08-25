import 'dart:collection';
import 'package:Fulltrip/services/notification.service.dart';
import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/widgets/lot/lot_screen_shell.dart';
import 'package:Fulltrip/widgets/confirmation_popup.dart';
import 'package:Fulltrip/widgets/action_buttons/accept_button.dart';
import 'package:Fulltrip/widgets/action_buttons/reject_button.dart';
import 'package:flutter/material.dart';

class LotValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LinkedHashMap<String, dynamic> args =
        ModalRoute.of(context).settings.arguments;
    final Lot lot = args['lot'];
    final reservedUserUid = args['sender_uid'];

    return LotScreenShell(
      lot: lot,
      companyName: args['sender_company_name'],
      acceptButton: AcceptButton(
        text: 'Accepter le transport',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            builder: (context) => ConfirmationPopup(
              confirmationText: 'Confirmez-vous cette réservation?',
              confirmationHint:
                  'J\'ai lu toutes les conditions générales et je confirme la réservation',
              acceptButtonText: 'Je confirme',
              rejectButtonText: 'Annuler',
              onAcceptButtonPressed: () {},
              onRejectButtonPressed: () => Navigator.pop(context),
            ),
          );
        },
      ),
      rejectButton: RejectButton(
        text: 'Refuser le transport',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            builder: (context) => ConfirmationPopup(
              confirmationText: 'Refusez-vous cette réservation?',
              acceptButtonText: 'Je refuse',
              rejectButtonText: 'Annuler',
              onAcceptButtonPressed: () {
                lot.removeReservedUser(reservedUserUid);
                NotificationService.rejectReservationNotification(
                    lot, reservedUserUid);

                Navigator.of(context).pushNamedAndRemoveUntil(
                    'success-screen', (Route<dynamic> route) => false);
              },
              onRejectButtonPressed: () => Navigator.pop(context),
            ),
          );
        },
      ),
    );
  }
}
