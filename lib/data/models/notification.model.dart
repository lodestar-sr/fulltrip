import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Notification {
  String uid;
  DateTime timestamp;
  String sender;
  String receiver;
  String text;
  int type;
  String lot;
  String senderCompanyName;

  Notification({
    this.uid,
    this.timestamp,
    this.sender,
    this.receiver,
    this.text,
    this.type,
    this.lot,
    this.senderCompanyName,
  }) {
    if (timestamp == null) {
      timestamp = DateTime.now();
    }
  }

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        uid: json["uid"],
        timestamp: json["timestamp"] != null
            ? json["timestamp"].toDate()
            : DateTime.now(),
        sender: json["sender"],
        receiver: json["receiver"],
        text: json["text"],
        type: json["type"],
        lot: json["lot"],
        senderCompanyName: json["senderCompanyName"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "timestamp": timestamp,
        "sender": sender,
        "receiver": receiver,
        "text": text,
        "type": type,
        "lot": lot,
        "senderCompanyName": senderCompanyName,
      };

  String formatTimestamp() {
    final now = DateTime.now().toLocal();
    final t = timestamp.toLocal();
    final diff = now.difference(timestamp);

    if (diff.inDays == 0 && t.day == now.day) {
      return '${t.hour}:${t.minute}';
    } else if (diff.inDays < 7 && t.weekday != now.weekday) {
      return DateFormat.E('fr_FR').format(t);
    } else if (diff.inDays < 365) {
      return DateFormat.MMMd('fr_FR').format(t);
    } else {
      return '${t.year}';
    }
  }
}

enum NotificationType {
  reservationValidation,
  confirmedReservation,
  refusedReservation,
  irrelevantReservation,
  confirmedReservationValidation,
  refusedReservationValidation,
  irrelevantReservationValidation,
}
