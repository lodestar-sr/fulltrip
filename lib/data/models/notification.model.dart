enum NotificationType {
  newReservation,
  confirmedReservation,
  rejectedReservation,
}

class Notification {
  String uid;
  String sender;
  String receiver;
  String text;
  int type;
  String lot;
  String senderCompanyName;

  Notification({
    this.uid,
    this.sender,
    this.receiver,
    this.text,
    this.type,
    this.lot,
    this.senderCompanyName,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        uid: json["uid"],
        sender: json["sender"],
        receiver: json["receiver"],
        text: json["text"],
        type: json["type"],
        lot: json["lot"],
        senderCompanyName: json["senderCompanyName"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "sender": sender,
        "receiver": receiver,
        "text": text,
        "type": type,
        "lot": lot,
        "senderCompanyName": senderCompanyName,
      };
}
