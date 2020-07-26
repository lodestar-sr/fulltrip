class Messages {
  String photo;
  String name;
  String message;
  DateTime time;
  int unread;
  String status;

  Messages({this.photo, this.name, this.message, this.time, this.unread, this.status});

  factory Messages.fromJson(Map<String, dynamic> json) =>
      Messages(photo: json["photo"], name: json["name"], message: json["message"], time: json["time"], unread: json["unread"], status: json["status"]);

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "name": name,
        "message": message,
        "time": time != null ? time.toIso8601String() : null,
        "unread": unread,
        "status": status,
      };
}
