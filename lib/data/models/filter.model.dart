class Filter {
  String startingAddress;
  String startingCity;
  String arrivalAddress;
  String arrivalCity;
  int quantity;
  int lowPrice;
  int highPrice;
  String delivery;
  DateTime pickUpDate;
  DateTime deliveryDate;

  Filter({
    this.startingAddress = '',
    this.startingCity = '',
    this.arrivalAddress = '',
    this.arrivalCity = '',
    this.quantity = 0,
    this.delivery = '',
    this.lowPrice = 0,
    this.highPrice = 10000,
    this.pickUpDate,
    this.deliveryDate,
  });

  reset() {
    this.startingAddress = '';
    this.startingCity = '';
    this.arrivalAddress = '';
    this.arrivalCity = '';
    this.quantity = 0;
    this.delivery = '';
    this.lowPrice = 0;
    this.highPrice = 10000;
    this.pickUpDate = null;
    this.deliveryDate = null;
  }

  resetStartingAddress() {
    this.startingAddress = '';
    this.startingCity = '';
  }

  resetArrivalAddress() {
    this.arrivalAddress = '';
    this.arrivalCity = '';
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
