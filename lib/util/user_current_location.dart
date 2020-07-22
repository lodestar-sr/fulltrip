import 'package:Fulltrip/util/global.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class UserCurrentLocation {
  static checkpermissionstatus() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        return checkpermissionstatus();
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        getCurrentLocation();
        return;
      }
    } else {
      getCurrentLocation();
    }
  }

  static Future getCurrentLocation() async {
    Location location = new Location();
    Geolocator _geolocator = Geolocator();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _locationData = await location.getLocation();
    List<Placemark> newPlace = await _geolocator.placemarkFromCoordinates(_locationData.latitude, _locationData.longitude);
    Placemark placeMark = newPlace[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    print(address);
    Global.address = address;
    print(_locationData.latitude);
    print(_locationData.longitude);
  }
}
