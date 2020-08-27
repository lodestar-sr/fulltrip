import 'dart:collection';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/widgets/confirmation_popup.dart';
import 'package:Fulltrip/widgets/lot/lot_screen_shell.dart';
import 'package:Fulltrip/widgets/action_buttons/accept_button.dart';
import 'package:Fulltrip/services/notification.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LotReservation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LinkedHashMap<String, Lot> args =
        ModalRoute.of(context).settings.arguments;
    final lot = args['lot'];

    return LotScreenShell(
      lot: lot,
      companyName: lot.proposedCompanyName,
      acceptButton: AcceptButton(
        text: 'Réserver ce lot',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            builder: (context) => ConfirmationPopup(
              confirmationText: 'Êtes-vous sûr de vouloir réserver ce lot?',
              acceptButtonText: 'Oui',
              rejectButtonText: 'Non',
              onAcceptButtonPressed: () {
                final reservedUser = context.read<AuthProvider>().loggedInUser;
                lot.addReservedUser(reservedUser.uid);
                NotificationService.addReservationValidationNotification(
                    lot, reservedUser);

                Navigator.of(context).pushNamedAndRemoveUntil(
                  'success-screen',
                  (_) => false,
                  arguments: {
                    'text':
                        'Ce lot a bien été réservé, prenez contact avec votre nouveau collaborateur.',
                    'company_name': reservedUser.raisonSociale,
                  },
                );
              },
              onRejectButtonPressed: () => Navigator.pop(context),
            ),
          );
        },
      ),
    );
  }
}
