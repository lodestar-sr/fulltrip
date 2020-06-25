import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fulltrip/util/constants.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:google_maps_webservice/places.dart';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Constants.googleAPIKey);

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
  State<StatefulWidget> createState() => _GooglePlacesAutocompleteState(prefixIcon, mode, language, components, initialValue, validator, onSelect, onChanged, onSaved);
}

class _GooglePlacesAutocompleteState extends State<GooglePlacesAutocomplete> {
  TextEditingController textEditingController = TextEditingController();

  Mode mode;
  String language;
  List<dynamic> components;
  String initialValue;
  FormFieldValidator<String> validator;
  ValueChanged<String> onSelect;
  ValueChanged<String> onChanged;
  ValueChanged<String> onSaved;
  EdgeInsets margin;
  EdgeInsets padding;
  Icon prefixIcon;

  _GooglePlacesAutocompleteState(Icon prefixIcon, Mode mode, String language, List<dynamic> components, String initialValue, FormFieldValidator<String> validator, ValueChanged<String> onSelect, ValueChanged<String> onChanged, ValueChanged<String> onSaved) {
    this.mode = mode;
    this.language = language;
    this.components = components;
    this.initialValue = initialValue;
    this.validator = validator;
    this.onSelect = onSelect;
    this.onChanged = onChanged;
    this.onSaved = onSaved;
    this.prefixIcon = prefixIcon;

    if (initialValue != null) {
      textEditingController.text = initialValue;
    }
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      final formattedAddress = detail.result.formattedAddress;

      setState(() {
        textEditingController.text = formattedAddress;
      });
      this.onSelect(formattedAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormFieldContainer(
      child: TextFormField(
        onTap: _handlePressButton,
        validator: validator,
        controller: textEditingController,
        onChanged: onChanged,
        onSaved: onSaved,
        readOnly: true,
        decoration: hintTextDecoration('Entrez s\'il vous plait').copyWith(prefixIcon: prefixIcon),
        style: AppStyles.blackTextStyle.copyWith(fontSize: 14),
      ),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Constants.googleAPIKey,
      onError: onError,
      mode: mode,
      language: language,
      components: components ?? [Component(Component.country, "fr")],
    );

    displayPrediction(p);
  }

  void onError(PlacesAutocompleteResponse response) {}
}
