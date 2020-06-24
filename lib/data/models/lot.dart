class Lot {
  int id;
  String name;
  String startAddress;
  String arrivalAddress;
  double price;
  double volume;
  String photo;
  DateTime date;
  String company;
  String service;

  Lot({
    this.id,
    this.name,
    this.startAddress,
    this.arrivalAddress,
    this.price,
    this.volume,
    this.photo,
    this.date,
    this.company,
    this.service,
  });

  factory Lot.fromJson(Map<String, dynamic> json) =>
    Lot(
      id: json["id"],
      name: json["name"],
      startAddress: json["startAddress"],
      arrivalAddress: json["arrivalAddress"],
      price: json["price"],
      volume: json["volume"],
      photo: json["photo"],
      date: json["date"],
      company: json["company"],
      service: json["service"],
    );

  Map<String, dynamic> toJson() =>
    {
      "id": id,
      "name": name,
      "startAddress": startAddress,
      "arrivalAddress": arrivalAddress,
      "price": price,
      "volume": volume,
      "photo": photo,
      "date": date,
      "company": company,
      "service": service,
    };
}