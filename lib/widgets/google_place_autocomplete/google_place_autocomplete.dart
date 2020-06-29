import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fulltrip/util/constants.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:google_maps_webservice/places.dart';

//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Constants.googleAPIKey);

class GooglePlacesAutocomplete extends StatefulWidget {
  final mode;
  final language;
  final components;
  final onSelect;
  final initialValue;
  final validator;
  final onChanged;
  final onSaved;
  final prefixIcon;

  GooglePlacesAutocomplete({
    this.mode = Mode.overlay,
    this.language = "fr",
    this.components,
    this.onSelect,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.prefixIcon,
  });

  @override
  State<StatefulWidget> createState() => _GooglePlacesAutocompleteState();
}

class _GooglePlacesAutocompleteState extends State<GooglePlacesAutocomplete> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      textEditingController.text = widget.initialValue;
    }
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
//      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
//      final lat = detail.result.geometry.location.lat;
//      final lng = detail.result.geometry.location.lng;
//      final formattedAddress = detail.result.formattedAddress;

      setState(() {
        textEditingController.text = p.description;
      });
      widget.onSelect(p.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: _handlePressButton,
      validator: widget.validator,
      controller: textEditingController,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      readOnly: true,
      decoration: hintTextDecoration('Entrez s\'il vous plait').copyWith(prefixIcon: widget.prefixIcon, contentPadding: EdgeInsets.only(top: 15)),
      style: AppStyles.blackTextStyle.copyWith(fontSize: 14),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Constants.googleAPIKey,
      onError: onError,
      mode: widget.mode,
      language: widget.language,
      components: widget.components ?? [Component(Component.country, "fr")],
    );

    displayPrediction(p);
  }

  void onError(PlacesAutocompleteResponse response) {}
}
