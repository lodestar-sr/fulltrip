import 'package:Fulltrip/util/address_utils.dart';
import 'package:Fulltrip/util/global.dart';

class Lot {
  String uid;
  String startingAddress;
  String startingCity;
  String startingLocationType;
  String startingAccessType;
  String startingFloors;
  String startingFurnitureLift;
  String startingDismantlingFurniture;
  DateTime pickupDateFrom;
  DateTime pickupDateTo;
  int quantity;

  String arrivalAddress;
  String arrivalCity;
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

  String proposedBy;
  String proposedCompanyName;
  List reservedBy;
  List refusedReservationFor;
  String assignedTo;
  String assignedCompanyName;

  double distanceInKm = 0.0;
  String time = '';

  Lot({
    this.uid,
    this.startingAddress = '',
    this.startingCity = '',
    this.startingLocationType = '',
    this.startingAccessType = '',
    this.startingFloors = '',
    this.startingFurnitureLift = 'Non',
    this.startingDismantlingFurniture = 'Non',
    this.pickupDateFrom,
    this.pickupDateTo,
    this.quantity = 0,
    this.arrivalAddress = '',
    this.arrivalCity = '',
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
    this.proposedBy,
    this.proposedCompanyName,
    this.reservedBy,
    this.refusedReservationFor,
    this.assignedTo,
    this.assignedCompanyName,
    this.distanceInKm = 0.0,
    this.time = '',
  });

  factory Lot.fromJson(Map<String, dynamic> json) => Lot(
        uid: json["uid"],
        startingAddress: json["starting_address"],
        startingCity: json["starting_city"],
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
        arrivalCity: json["arrival_city"],
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
        proposedBy: json['proposed_by'],
        proposedCompanyName: json['proposed_company_name'],
        reservedBy: json['reserved_by'],
        refusedReservationFor: json['refused_reservation_for'],
        assignedTo: json['assigned_to'],
        assignedCompanyName: json['assigned_company_name'],
        distanceInKm:
            json['distance_InKm'] != null ? json['distance_InKm'] : 0.0,
        time: json['time'] != null ? json['time'] : '',
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "starting_address": startingAddress,
        "starting_city": startingCity,
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
        "arrival_city": arrivalCity,
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
        "proposed_by": proposedBy,
        "proposed_company_name": proposedCompanyName,
        "reserved_by": reservedBy ?? [],
        "refused_reservation_for": refusedReservationFor ?? [],
        "assigned_to": assignedTo,
        "assigned_company_name": assignedCompanyName,
        "distance_InKm": distanceInKm ?? 0.0,
        "time": time ?? ''
      };

  Future<void> setCityFromStartingAddress() async {
    startingCity = await AddressUtils.getCityFromAddress(startingAddress);
  }

  Future<void> setCityFromArrivalAddress() async {
    arrivalCity = await AddressUtils.getCityFromAddress(arrivalAddress);
  }

  void setAssignedUser(String userUid, String companyName) {
    assignedTo = userUid;
    assignedCompanyName = companyName;
    Global.firestore.collection('lots').document(uid).updateData({
      'assigned_to': assignedTo,
      'assigned_company_name': assignedCompanyName,
    });
  }

  void addReservedUser(String userUid) {
    reservedBy.add(userUid);
    Global.firestore
        .collection('lots')
        .document(uid)
        .updateData({'reserved_by': reservedBy});
  }

  void addRefusedReservationUser(String userUid) {
    refusedReservationFor.add(userUid);
    Global.firestore
        .collection('lots')
        .document(uid)
        .updateData({'refused_reservation_for': refusedReservationFor});
  }

  ProposedLotStatus getProposedStatus() {
    if (reservedBy.length == 0 ||
        reservedBy.length == refusedReservationFor.length) {
      return ProposedLotStatus.published;
    } else if (assignedTo == null) {
      return ProposedLotStatus.validating;
    } else {
      return ProposedLotStatus.ongoing;
    }
  }

  ReservedLotStatus getReservedStatus(String userUid) {
    if (assignedTo == userUid) {
      return ReservedLotStatus.ongoing;
    } else if (refusedReservationFor.contains(userUid)) {
      return ReservedLotStatus.refused;
    } else if (assignedTo != null) {
      return ReservedLotStatus.irrelevant;
    } else {
      return ReservedLotStatus.reserved;
    }
  }
}

enum ProposedLotStatus {
  published,
  validating,
  ongoing,
}

extension ProposedLotStatusExtension on ProposedLotStatus {
  // ignore: missing_return
  String get string {
    switch (this) {
      case ProposedLotStatus.published:
        return 'Publié';
      case ProposedLotStatus.validating:
        return 'Être validé';
      case ProposedLotStatus.ongoing:
        return 'En cours';
    }
  }
}

enum ReservedLotStatus {
  reserved,
  ongoing,
  refused,
  irrelevant,
}

extension ReservedLotStatusExtension on ReservedLotStatus {
  // ignore: missing_return
  String get string {
    switch (this) {
      case ReservedLotStatus.reserved:
        return 'Réservé';
      case ReservedLotStatus.ongoing:
        return 'En cours';
      case ReservedLotStatus.refused:
        return 'Refusé';
      case ReservedLotStatus.irrelevant:
        return 'Invalide';
    }
  }
}
