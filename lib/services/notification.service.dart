import 'package:Fulltrip/data/models/notification.model.dart';
import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/util/global.dart';

class NotificationService {
  static Future<List<Notification>> getNotificationsForUser(
      String userUid) async {
    final querySnapshot = await Global.firestore
        .collection('notifications')
        .where('receiver', isEqualTo: userUid)
        .getDocuments();
    return querySnapshot.documents
        .map((document) => Notification.fromJson(document.data))
        .toList();
  }

  static void addNewReservationNotification(Lot lot, User reservedUser) {
    final notification = Notification(
      sender: reservedUser.uid,
      receiver: lot.proposedBy,
      text: 'Votre lot ${lot.startingCity} -> ${lot.arrivalCity} a été réservé',
      type: NotificationType.newReservation.index,
      lot: lot.uid,
      senderCompanyName: reservedUser.raisonSociale,
    );

    final document = Global.firestore.collection('notifications').document();
    notification.uid = document.documentID;
    document.setData(notification.toJson());
  }

  static void rejectReservationNotification(Lot lot, String reservedUserUid) {
    final notification = Notification(
      sender: lot.proposedBy,
      receiver: reservedUserUid,
      text:
          'Votre réservation ${lot.startingCity} -> ${lot.arrivalCity} a été refusée',
      type: NotificationType.rejectedReservation.index,
      lot: lot.uid,
      senderCompanyName: lot.proposedCompanyName,
    );

    final document = Global.firestore.collection('notifications').document();
    notification.uid = document.documentID;
    document.setData(notification.toJson());
  }
}
