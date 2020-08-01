import 'package:Fulltrip/util/uuid.dart';

class Lot {
  String id;
  String startingAddress;
  String startingLocationType;
  String startingAccessType;
  String startingFloors;
  String startingFurnitureLift;
  String startingDismantlingFurniture;
  DateTime pickupDateFrom;
  DateTime pickupDateTo;
  int quantity;

  String arrivalAddress;
  String arrivalLocationType;
  String arrivalAccessType;
  String arrivalFloors;
  String arrivalFurnitureLift;
  String arrivalReassemblyFurniture;
  String delivery;
  DateTime deliveryDateFrom;
  DateTime deliveryDateTo;

  double price;
  String photo;
  String description;
  DateTime date;

  Lot({
    this.id,
    this.startingAddress = '',
    this.startingLocationType = '',
    this.startingAccessType = '',
    this.startingFloors = '',
    this.startingFurnitureLift = 'Non',
    this.startingDismantlingFurniture = 'Non',
    this.pickupDateFrom,
    this.pickupDateTo,
    this.quantity = 0,
    this.arrivalAddress = '',
    this.arrivalLocationType = '',
    this.arrivalAccessType = '',
    this.arrivalFloors = '',
    this.arrivalFurnitureLift = 'Non',
    this.arrivalReassemblyFurniture = 'Non',
    this.delivery = '',
    this.deliveryDateFrom,
    this.deliveryDateTo,
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
        pickupDateFrom: json["pickup_date_from"] != null
            ? DateTime.parse(json["pickup_date_from"])
            : null,
        pickupDateTo: json["pickup_date_to"] != null
            ? DateTime.parse(json["pickup_date_to"])
            : null,
        quantity: json["quantity"],
        arrivalAddress: json["arrival_address"],
        arrivalLocationType: json["arrival_location_type"],
        arrivalAccessType: json["arrival_access_type"],
        arrivalFloors: json["arrival_floors"],
        arrivalFurnitureLift: json["arrival_furniture_lift"],
        arrivalReassemblyFurniture: json["arrival_reassembly_furniture"],
        delivery: json["delivery"],
        deliveryDateFrom: json["delivery_date_from"] != null
            ? DateTime.parse(json["delivery_date_from"])
            : null,
        deliveryDateTo: json["delivery_date_to"] != null
            ? DateTime.parse(json["delivery_date_to"])
            : null,
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
        "pickup_date_from":
            pickupDateFrom != null ? pickupDateFrom.toIso8601String() : null,
        "pickup_date_to":
            pickupDateTo != null ? pickupDateTo.toIso8601String() : null,
        "quantity": quantity,
        "arrival_address": arrivalAddress,
        "arrival_location_type": arrivalLocationType,
        "arrival_access_type": arrivalAccessType,
        "arrival_floors": arrivalFloors,
        "arrival_furniture_lift": arrivalFurnitureLift,
        "arrival_reassembly_furniture": arrivalReassemblyFurniture,
        "delivery": delivery,
        "delivery_date_from": deliveryDateFrom != null
            ? deliveryDateFrom.toIso8601String()
            : null,
        "delivery_date_to":
            deliveryDateTo != null ? deliveryDateTo.toIso8601String() : null,
        "price": price,
        "photo": photo,
        "description": description,
        "date": date.toIso8601String(),
      };
}
