

class Filter {
  String startingAddress;
  String arrivalAddress;
  int quantity;
  int lowPrice;
  int highPrice;
  String delivery;
  DateTime pickUpDate;
  DateTime deliveryDate;

  Filter({
    this.startingAddress = '',
    this.arrivalAddress = '',
    this.quantity = 0,
    this.delivery = '',
    this.lowPrice = 0,
    this.highPrice = 10000,
    this.pickUpDate,
    this.deliveryDate,
  });

  reset() {
    this.startingAddress = '';
    this.arrivalAddress = '';
    this.quantity = 0;
    this.delivery = '';
    this.lowPrice = 0;
    this.highPrice = 10000;
    this.pickUpDate = null;
    this.deliveryDate = null;
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

  resetPickUpDate() {
    this.pickUpDate = null;
  }

  resetDeliveryDate() {
    this.deliveryDate = null;
  }
}
