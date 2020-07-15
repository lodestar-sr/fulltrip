import 'package:fulltrip/util/uuid.dart';

class Filter {
  String startingAddress;
  String arrivalAddress;
  int quantity;
  int lowPrice;
  int highPrice;
  String delivery;

  Filter({
    this.startingAddress = '',
    this.arrivalAddress = '',
    this.quantity = 0,
    this.delivery = '',
    this.lowPrice = 0,
    this.highPrice = 10000,
  });

  clear() {
    this.startingAddress = '';
    this.arrivalAddress = '';
    this.quantity = 0;
    this.delivery = '';
    this.lowPrice = 0;
    this.highPrice = 10000;
  }

  resetStartingAddress() {
    this.startingAddress = '';
  }

  resetArrivalAddress() {
    this.arrivalAddress = '';
  }

  resetQuantity() {
    this.quantity = 0;
  }

  resetDelivery() {
    this.delivery = '';
  }

  resetPrice() {
    this.lowPrice = 0;
    this.highPrice = 10000;
  }
}
