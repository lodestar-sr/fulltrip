import 'package:Fulltrip/util/global.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;

class UserCurrentLocation {
  static checkpermissionstatus() async {
    loc.Location location = new loc.Location();
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        return checkpermissionstatus();
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        getCurrentLocation();
        return;
      }
    } else {
      getCurrentLocation();
    }
  }

  static Future getCurrentLocation() async {
    Geolocator _geolocator = Geolocator();
    Position pos = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> newPlace =
        await _geolocator.placemarkFromCoordinates(pos.latitude, pos.longitude);
    Placemark placeMark = newPlace[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address =
        "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    Global.address = address;
  }
}
