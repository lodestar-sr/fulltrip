import 'package:fulltrip/util/uuid.dart';

class Lot {
  String id;
  String startingAddress;
  String startingLocationType;
  String startingAccessType;
  String startingFloors;
  String startingFurnitureLift;
  String startingDismantlingFurniture;
  int quantity;

  String arrivalAddress;
  String arrivalLocationType;
  String arrivalAccessType;
  String arrivalFloors;
  String arrivalFurnitureLift;
  String arrivalReassemblyFurniture;
  String delivery;

  double price;
  String photo;
  String description;
  DateTime date;

  Lot({
    this.id,
    this.startingAddress = '',
    this.startingLocationType = 'Immeuble',
    this.startingAccessType = 'Plein',
    this.startingFloors = 'RDC',
    this.startingFurnitureLift = 'Non',
    this.startingDismantlingFurniture = 'Non',
    this.quantity = 0,
    this.arrivalAddress = '',
    this.arrivalLocationType = 'Immeuble',
    this.arrivalAccessType = 'Plein',
    this.arrivalFloors = 'RDC',
    this.arrivalFurnitureLift = 'Non',
    this.arrivalReassemblyFurniture = 'Non',
    this.delivery = '',
    this.price,
    this.photo = '',
    this.description = '',
    this.date,
  }) {
    if (id == null) {
      id = Uuid().generateV4();
    }
  }

  factory Lot.fromJson(Map<String, dynamic> json) => Lot(
        id: json["id"],
        startingAddress: json["starting_address"],
        startingLocationType: json["starting_location_type"],
        startingAccessType: json["starting_access_type"],
        startingFloors: json["starting_floors"],
        startingFurnitureLift: json["starting_furniture_lift"],
        startingDismantlingFurniture: json["starting_dismantling_furniture"],
        quantity: json["quantity"],
        arrivalAddress: json["arrival_address"],
        arrivalLocationType: json["arrival_location_type"],
        arrivalAccessType: json["arrival_access_type"],
        arrivalFloors: json["arrival_floors"],
        arrivalFurnitureLift: json["arrival_furniture_lift"],
        arrivalReassemblyFurniture: json["arrival_reassembly_furniture"],
        delivery: json["delivery"],
        price: json["price"],
        photo: json["photo"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "starting_address": startingAddress,
        "starting_location_type": startingLocationType,
        "starting_access_type": startingAccessType,
        "starting_floors": startingFloors,
        "starting_furniture_lift": startingFurnitureLift,
        "starting_dismantling_furniture": startingDismantlingFurniture,
        "quantity": quantity,
        "arrival_address": arrivalAddress,
        "arrival_location_type": arrivalLocationType,
        "arrival_access_type": arrivalAccessType,
        "arrival_floors": arrivalFloors,
        "arrival_furniture_lift": arrivalFurnitureLift,
        "arrival_reassembly_furniture": arrivalReassemblyFurniture,
        "delivery": delivery,
        "price": price,
        "photo": photo,
        "description": description,
        "date": date.toIso8601String(),
      };
}
