import 'package:geolocator/geolocator.dart';

class AddressUtils {
  static final _geolocator = Geolocator();

  static Future<String> getCityFromAddress(String address) async {
    String city;
    try {
      final List<Placemark> placemark = await _geolocator.placemarkFromAddress(
        address,
        localeIdentifier: 'fr_FR',
      );
      city = placemark[0].locality;
      if (city == '') throw Error();
    } catch (_) {
      final addressList = address.split(',');
      if (addressList.length >= 2) {
        city = addressList[addressList.length - 2].trim();
      } else {
        city = addressList[0].trim();
      }
    }
    return city;
  }
}
