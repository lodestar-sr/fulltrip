import 'package:Fulltrip/data/models/notification.model.dart';
import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/util/global.dart';

class NotificationService {
  static List<int> _typesToUpdate = [
    NotificationType.reservationValidation.index,
    NotificationType.refusedReservationValidation.index,
  ];

  static Future<List<Notification>> getNotificationsForUser(
      String userUid) async {
    final querySnapshot = await Global.firestore
        .collection('notifications')
        .where('receiver', isEqualTo: userUid)
        .orderBy('timestamp', descending: true)
        .getDocuments();
    return querySnapshot.documents
        .map((document) => Notification.fromJson(document.data))
        .toList();
  }

  static void _addToDatabase(Notification notification) {
    final document = Global.firestore.collection('notifications').document();
    notification.uid = document.documentID;
    document.setData(notification.toJson());
  }

  static void _updateReservationValidationNotificationType(
      String lotUid, String senderUid, NotificationType newType) async {
    final querySnapshot = await Global.firestore
        .collection('notifications')
        .where('lot', isEqualTo: lotUid)
        .where('sender', isEqualTo: senderUid)
        .where('type', whereIn: _typesToUpdate)
        .getDocuments();
    for (final document in querySnapshot.documents) {
      Global.firestore
          .collection('notifications')
          .document(document.documentID)
          .updateData({'type': newType.index});
    }
  }

  static void addReservationValidationNotification(Lot lot, User reservedUser) {
    final notification = Notification(
      sender: reservedUser.uid,
      receiver: lot.proposedBy,
      text: 'Votre lot ${lot.startingCity} -> ${lot.arrivalCity} a été réservé',
      type: NotificationType.reservationValidation.index,
      lot: lot.uid,
      senderCompanyName: reservedUser.raisonSociale,
    );
    _addToDatabase(notification);
  }

  static void addRefusedReservationNotification(
      Lot lot, String reservedUserUid) {
    final notification = Notification(
      sender: lot.proposedBy,
      receiver: reservedUserUid,
      text:
          'Votre réservation ${lot.startingCity} -> ${lot.arrivalCity} a été refusée',
      type: NotificationType.refusedReservation.index,
      lot: lot.uid,
      senderCompanyName: lot.proposedCompanyName,
    );
    _addToDatabase(notification);

    _updateReservationValidationNotificationType(lot.uid, reservedUserUid,
        NotificationType.refusedReservationValidation);
  }

  static void addConfirmedReservationNotification(Lot lot) {
    final notification = Notification(
      sender: lot.proposedBy,
      receiver: lot.assignedTo,
      text:
          'Votre réservation ${lot.startingCity} -> ${lot.arrivalCity} a été acceptée, prenez contacte avec votre nouveau collaborateur',
      type: NotificationType.confirmedReservation.index,
      lot: lot.uid,
      senderCompanyName: lot.proposedCompanyName,
    );
    _addToDatabase(notification);

    _updateReservationValidationNotificationType(lot.uid, lot.assignedTo,
        NotificationType.confirmedReservationValidation);
  }

  static void addIrrelevantReservationNotifications(Lot lot) {
    final notification = Notification(
      sender: lot.proposedBy,
      text:
          'Un autre transporteur a été sélectionné pour lot ${lot.startingCity} -> ${lot.arrivalCity}',
      type: NotificationType.irrelevantReservation.index,
      lot: lot.uid,
      senderCompanyName: lot.proposedCompanyName,
    );

    final irrelevantUsers = Set<String>.from(lot.reservedBy)
      ..removeAll(lot.refusedReservationFor + [lot.assignedTo]);

    for (final userUid in irrelevantUsers) {
      notification.receiver = userUid;
      _addToDatabase(notification);

      _updateReservationValidationNotificationType(
          lot.uid, userUid, NotificationType.irrelevantReservationValidation);
    }
  }
}
