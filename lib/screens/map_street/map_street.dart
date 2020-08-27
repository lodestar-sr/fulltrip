import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:Fulltrip/widgets/google_place_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapStreet extends StatefulWidget {
  MapStreet({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapStreetState();
}

class _MapStreetState extends State<MapStreet> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();

  String _mapStyle;

  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  LatLng _pinPosition = LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    initData();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/pin.png').then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  initData() {
    _getCurrentLocation();
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      setState(() async {
        _pinPosition = LatLng(position.latitude, position.longitude);
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _pinPosition, zoom: 15),
          ),
        );
        Marker marker = _markers.firstWhere((p) => p.markerId == MarkerId('1'), orElse: () => null);

        _markers.remove(marker);
        _markers.add(Marker(
            markerId: MarkerId('1'),
            position: _pinPosition,
            draggable: true,
            onDragEnd: ((value) {
              print(value.latitude);
              print(value.longitude);
            }),
            icon: pinLocationIcon));
        try {
          List<Placemark> newPlace = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
          Placemark placeMark = newPlace[0];
          String name = placeMark.name;
          String administrativeArea = placeMark.administrativeArea;
          String postalCode = placeMark.postalCode;
          String country = placeMark.country;
          String address = "${name}, ${administrativeArea} ${postalCode}, ${country}";
          setState(() {
            print(address);
            Global.address = address;
          });
        } catch (e) {
          print(e);
        }
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _resetMarker(String newAddress) async {
    List<Placemark> placemark = await Geolocator().placemarkFromAddress(newAddress);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(placemark[0].position.latitude, placemark[0].position.longitude), zoom: 15),
      ),
    );

    _updatePosition(CameraPosition(target: LatLng(placemark[0].position.latitude, placemark[0].position.longitude)));
  }

  void _updatePosition(CameraPosition _position) async {
    print(_position.target.latitude);
    print(_position.target.longitude);
    print('inside updatePosition ${_position.target.latitude} ${_position.target.longitude}');
    Marker marker = _markers.firstWhere((p) => p.markerId == MarkerId('1'), orElse: () => null);

    _markers.remove(marker);
    _markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: true,
        icon: pinLocationIcon,
      ),
    );
    setState(() {});
  }

  addAddressToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('globaladdress', Global.address);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: GoogleMap(
                initialCameraPosition: _initialLocation,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: false,
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  mapController.setMapStyle(_mapStyle);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 72, 16, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.close, size: 25),
                        onTap: () => Navigator.of(context).pushReplacementNamed('dashboard'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                            child: Text(
                          Global.address,
                          style: AppStyles.blackTextStyle.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                width: 220,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(35)),
                                child: GooglePlacesAutocomplete(
                                  underline: InputBorder.none,
                                  padding: EdgeInsets.all(10),
                                  initialValue: Global.address,
                                  hintText: 'Entrez votre adresse',
                                  onSelect: (val) {
                                    setState(() {
                                      Global.address = val;
                                      _resetMarker(val);
                                    });
                                  },
                                ),
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                _getCurrentLocation();
                              },
                              elevation: 2.0,
                              fillColor: Colors.white,
                              child: Icon(
                                FontAwesome.location_arrow,
                                size: 20,
                              ),
                              padding: EdgeInsets.all(12),
                              shape: CircleBorder(),
                            ),
                          ],
                        ),
                      ),
                      ButtonTheme(
                        minWidth: double.infinity,
                        height: 45,
                        child: RaisedButton(
                          child: Text('Je suis là', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          color: AppColors.primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('dashboard');
                            addAddressToSF();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
