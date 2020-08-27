import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/description_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class LotWidget extends StatefulWidget {
  final Lot lot;
  final String companyName;
  final double distanceInKm;
  final String time;

  LotWidget({
    this.lot,
    this.companyName,
    this.distanceInKm,
    this.time,
  });

  @override
  _LotWidgetState createState() => _LotWidgetState();
}

class _LotWidgetState extends State<LotWidget> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;
  Position _currentPosition;
  String _mapStyle;
  final Geolocator _geolocator = Geolocator();
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor deliveryIcon;
  Set<Marker> _markers = {};
  LatLng _pinPosition = LatLng(0.0, 0.0);
  BitmapDescriptor startingLocationIcon;
  BitmapDescriptor arrivalLocationIcon;
  LatLng _startingLocationPosition = LatLng(0.0, 0.0);
  LatLng _arrivalLocationPosition = LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();

    _resetMarker(widget.lot.startingAddress, widget.lot.arrivalAddress);
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/arrivalpin.png')
        .then((onValue) {
      arrivalLocationIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/pin.png')
        .then((onValue) {
      startingLocationIcon = onValue;
    });
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      List<Placemark> placemark =
          await Geolocator().placemarkFromAddress(widget.lot.arrivalAddress);

      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        _pinPosition = LatLng(
            placemark[0].position.latitude, placemark[0].position.longitude);

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _pinPosition, zoom: 9),
          ),
        );
        _markers.add(Marker(
            markerId: MarkerId('<MARKER_ID>'),
            position: _pinPosition,
            icon: pinLocationIcon));
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _resetMarker(String startingAddress, String arrivalAddress) async {
    List<Placemark> startingplacemark =
        await Geolocator().placemarkFromAddress(startingAddress);
    List<Placemark> arrivalplacemark =
        await Geolocator().placemarkFromAddress(arrivalAddress);
    _arrivalLocationPosition = LatLng(arrivalplacemark[0].position.latitude,
        arrivalplacemark[0].position.longitude);
    _startingLocationPosition = LatLng(startingplacemark[0].position.latitude,
        startingplacemark[0].position.longitude);
    await updateCameraLocation(
        LatLng(startingplacemark[0].position.latitude,
            startingplacemark[0].position.longitude),
        LatLng(arrivalplacemark[0].position.latitude,
            arrivalplacemark[0].position.longitude),
        mapController);

    _updatePosition(
        CameraPosition(
            target: LatLng(startingplacemark[0].position.latitude,
                startingplacemark[0].position.longitude)),
        CameraPosition(
            target: LatLng(arrivalplacemark[0].position.latitude,
                arrivalplacemark[0].position.longitude)));
    setState(() {});
  }

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController mapController,
  ) async {
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 30);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  void _updatePosition(
      CameraPosition _startingposition, CameraPosition _arrivalposition) async {
    //Starting Address Marker
    Marker startingmarker = _markers.firstWhere(
        (p) => p.markerId == MarkerId('starting'),
        orElse: () => null);

    _markers.remove(startingmarker);
    _markers.add(
      Marker(
        markerId: MarkerId('starting'),
        position: LatLng(_startingposition.target.latitude,
            _startingposition.target.longitude),
        draggable: true,
        icon: startingLocationIcon,
      ),
    );
    //Starting Address Marker
    Marker arrivalmarker = _markers.firstWhere(
        (p) => p.markerId == MarkerId('arrival'),
        orElse: () => null);

    _markers.remove(arrivalmarker);
    _markers.add(
      Marker(
        markerId: MarkerId('arrival'),
        position: LatLng(_arrivalposition.target.latitude,
            _arrivalposition.target.longitude),
        draggable: true,
        icon: arrivalLocationIcon,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final myFormat = DateFormat('d/MM');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        widget.lot.photo != ''
            ? Container(
                width: double.infinity,
                height: 146,
                margin: EdgeInsets.only(top: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  image: DecorationImage(
                    image: NetworkImage(widget.lot.photo),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                height: 146,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: AppColors.lightGreyColor,
                ),
                margin: EdgeInsets.only(right: 14),
                child: Center(
                  child: Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/noimage.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 5),
          child: Row(
            children: [
              Icon(MaterialCommunityIcons.calendar_range,
                  size: 20, color: AppColors.primaryColor),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text('Publié le ${myFormat.format(widget.lot.date)}',
                    style: AppStyles.blackTextStyle.copyWith(fontSize: 15)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Divider(),
        ),
        Container(
          height: 200,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(bottom: 10),
          child: GoogleMap(
            scrollGesturesEnabled: true,
            initialCameraPosition: _initialLocation,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              mapController.setMapStyle(_mapStyle);
            },
          ),
        ),
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 4, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(MaterialCommunityIcons.circle_slice_8,
                        size: 20, color: AppColors.primaryColor),
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      width: 9,
                      child: Dash(
                        direction: Axis.vertical,
                        length: 40,
                        dashLength: 6,
                        dashThickness: 2,
                        dashColor: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text(
                        widget.lot.startingAddress,
                        style: AppStyles.blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    widget.lot.pickupDateFrom != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              'du ${myFormat.format(widget.lot.pickupDateFrom)} au ${myFormat.format(widget.lot.pickupDateTo)}',
                              style: AppStyles.greyTextStyle.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 13),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5, top: 5, left: 8),
          child: Text('${widget.lot.time}  (${widget.lot.distanceInKm} km)',
              style: AppStyles.blackTextStyle.copyWith(fontSize: 12)),
        ),
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 9,
                        child: Dash(
                          direction: Axis.vertical,
                          length: 40,
                          dashLength: 6,
                          dashThickness: 2,
                          dashColor: AppColors.greyColor,
                        )),
                    SizedBox(
                      height: 3,
                    ),
                    Icon(Feather.map_pin, size: 20, color: AppColors.redColor),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text(
                        widget.lot.arrivalAddress,
                        style: AppStyles.blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    widget.lot.deliveryDateFrom != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              'du ${myFormat.format(widget.lot.deliveryDateFrom)} au ${myFormat.format(widget.lot.deliveryDateTo)}',
                              style: AppStyles.greyTextStyle
                                  .copyWith(fontSize: 12),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Divider(
            color: AppColors.lightGreyColor,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0, bottom: 10.0),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text("Parcourir les détails",
                  style: AppStyles.primaryTextStyle
                      .copyWith(fontWeight: FontWeight.w500)),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(
                          "Au départ",
                          style: AppStyles.blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4, top: 4),
                          child: Text('Type de lieu',
                              style: AppStyles.blackTextStyle
                                  .copyWith(fontSize: 14)),
                        ),
                        Text('${widget.lot.startingLocationType.trim()}',
                            style: AppStyles.blackTextStyle.copyWith(
                                color: AppColors.backButtonColor,
                                fontSize: 14)),
                        widget.lot.startingAccessType.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 4, top: 8),
                                child: Text("Type d'accès",
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14)),
                              )
                            : Container(),
                        widget.lot.startingAccessType.isNotEmpty
                            ? Text('${widget.lot.startingAccessType}',
                                style: AppStyles.blackTextStyle.copyWith(
                                    color: AppColors.backButtonColor,
                                    fontSize: 14))
                            : Container(),
                        widget.lot.startingFloors.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 4, top: 8),
                                child: Text("Etages",
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14)),
                              )
                            : Container(),
                        widget.lot.startingFloors.isNotEmpty
                            ? Text('${widget.lot.startingFloors}',
                                style: AppStyles.blackTextStyle.copyWith(
                                    color: AppColors.backButtonColor,
                                    fontSize: 14))
                            : Container(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(
                          "À l'arrivée",
                          style: AppStyles.blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4, top: 4),
                          child: Text('Type de lieu                ',
                              style: AppStyles.blackTextStyle
                                  .copyWith(fontSize: 14)),
                        ),
                        Text('${widget.lot.arrivalLocationType}',
                            style: AppStyles.blackTextStyle.copyWith(
                                color: AppColors.backButtonColor,
                                fontSize: 14)),
                        widget.lot.arrivalAccessType.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 4, top: 8),
                                child: Text("Type d'accès",
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14)),
                              )
                            : Container(),
                        widget.lot.arrivalAccessType.isNotEmpty
                            ? Text('${widget.lot.arrivalAccessType}',
                                style: AppStyles.blackTextStyle.copyWith(
                                    color: AppColors.backButtonColor,
                                    fontSize: 14))
                            : Container(),
                        widget.lot.arrivalFloors.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 4, top: 8),
                                child: Text("Etages",
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 14)),
                              )
                            : Container(),
                        widget.lot.arrivalFloors.isNotEmpty
                            ? Text('${widget.lot.arrivalFloors}',
                                style: AppStyles.blackTextStyle.copyWith(
                                    color: AppColors.backButtonColor,
                                    fontSize: 14))
                            : Container(),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Divider(
                    color: AppColors.lightGreyColor,
                    thickness: 1,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.lot.startingFurnitureLift != 'Non'
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: Text('Monte meubles',
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)),
                                )
                              : Container(),
                          widget.lot.startingFurnitureLift != 'Non'
                              ? Text('${widget.lot.startingFurnitureLift}',
                                  style: AppStyles.blackTextStyle.copyWith(
                                      color: AppColors.backButtonColor,
                                      fontSize: 14))
                              : Container(),
                          Container(padding: EdgeInsets.all(4)),
                          widget.lot.startingDismantlingFurniture != 'Non'
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: Text('Démontage meubles',
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)),
                                )
                              : Container(),
                          widget.lot.startingDismantlingFurniture != 'Non'
                              ? Text(
                                  '${widget.lot.startingDismantlingFurniture}',
                                  style: AppStyles.blackTextStyle.copyWith(
                                      color: AppColors.backButtonColor,
                                      fontSize: 14))
                              : Container(),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.lot.arrivalFurnitureLift != 'Non'
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: Text('Monte meubles',
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)),
                                )
                              : Container(),
                          widget.lot.arrivalFurnitureLift != 'Non'
                              ? Text('${widget.lot.arrivalFurnitureLift}',
                                  style: AppStyles.blackTextStyle.copyWith(
                                      color: AppColors.backButtonColor,
                                      fontSize: 14))
                              : Container(),
                          Container(padding: EdgeInsets.all(4)),
                          widget.lot.arrivalReassemblyFurniture != 'Non'
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 4, top: 4),
                                  child: Text('Remontage meubles',
                                      style: AppStyles.blackTextStyle
                                          .copyWith(fontSize: 14)),
                                )
                              : Container(),
                          widget.lot.arrivalReassemblyFurniture != 'Non'
                              ? Text('${widget.lot.arrivalReassemblyFurniture}',
                                  style: AppStyles.blackTextStyle.copyWith(
                                      color: AppColors.backButtonColor,
                                      fontSize: 14))
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 4, top: 4),
          child: Text('Volume',
              style: AppStyles.blackTextStyle
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 17)),
        ),
        Text('${widget.lot.quantity}m³',
            style: AppStyles.blackTextStyle
                .copyWith(color: AppColors.primaryColor, fontSize: 18)),
        widget.lot.description.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(bottom: 4, top: 15),
                child: Text('La description',
                    style: AppStyles.blackTextStyle
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 17)),
              )
            : Container(),
        widget.lot.description.isNotEmpty
            ? DescriptionText(
                text: widget.lot.description,
                minLength: 60,
                textStyle: AppStyles.greyTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: AppColors.backButtonColor,
                    height: 1.3),
                moreTextStyle: AppStyles.primaryTextStyle.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 13, height: 1.4),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text('Prix de l\'expédition',
              style: AppStyles.blackTextStyle.copyWith(fontSize: 18)),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            '${widget.lot.price.toStringAsFixed(0)}€',
            style: AppStyles.darkGreyTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
                fontSize: 24),
          ),
        ),
        SizedBox(height: 25),
        widget.companyName != null
            ? Text(
                widget.companyName,
                style: AppStyles.blackTextStyle
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 17),
              )
            : SizedBox(),
        widget.companyName != null
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Feather.message_square,
                        size: 18,
                        color: AppColors.primaryColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Contacter l\'entreprise',
                          style: AppStyles.primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(),
        SizedBox(height: 25),
      ],
    );
  }
}
