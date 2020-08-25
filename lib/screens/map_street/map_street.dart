import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:Fulltrip/widgets/google_place_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MapStreet extends StatefulWidget {
  MapStreet({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapStreetState();
}

class _MapStreetState extends State<MapStreet> {
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(0.0, 0.0), zoom: 18);
  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    _getCurrentLocation();
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude)),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
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
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 72, 16, 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Icon(Icons.close, size: 16),
                    onTap: () =>
                        Navigator.of(context).pushReplacementNamed('dashboard'),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 24),
                            width: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GooglePlacesAutocomplete(
                              initialValue: '',
                              hintText: 'Entrez votre adresse de livraison',
                            ),
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Icon(FontAwesome.location_arrow),
                            padding: EdgeInsets.all(8),
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                      ButtonTheme(
                        minWidth: double.infinity,
                        height: 45,
                        child: RaisedButton(
                          child: Text('Je suis là',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          color: AppColors.primaryColor,
                          textColor: Colors.white,
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed('dashboard'),
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
