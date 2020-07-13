import 'dart:convert';
import 'package:fulltrip/util/constants.dart';
import 'package:http/http.dart' as http;

class DistanceTimeModel {
  List<String> destinationAddresses;
  List<String> originAddresses;
  List<Rows> rows;
  String status;

  DistanceTimeModel(
      {this.destinationAddresses,
      this.originAddresses,
      this.rows,
      this.status});

  DistanceTimeModel.fromJson(Map<String, dynamic> json) {
    destinationAddresses = json['destination_addresses'].cast<String>();
    originAddresses = json['origin_addresses'].cast<String>();
    if (json['rows'] != null) {
      rows = new List<Rows>();
      json['rows'].forEach((v) {
        rows.add(new Rows.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination_addresses'] = this.destinationAddresses;
    data['origin_addresses'] = this.originAddresses;
    if (this.rows != null) {
      data['rows'] = this.rows.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Rows {
  List<Elements> elements;

  Rows({this.elements});

  Rows.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = new List<Elements>();
      json['elements'].forEach((v) {
        elements.add(new Elements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.elements != null) {
      data['elements'] = this.elements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elements {
  Distance distance;
  Distance duration;
  String status;

  Elements({this.distance, this.duration, this.status});

  Elements.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Distance {
  String text;
  int value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    return data;
  }
}

/////
Future<DistanceTimeModel> fetchRequestGoogleApi(double startinglat,
    double startinglong, double arrivallat, double arrivallong) async {
  final response = await http.get(
      'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$startinglat,$startinglong&destinations=$arrivallat,$arrivallong&key=${Constants.googleAPIKey}');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return DistanceTimeModel.fromJson(json.decode(response.body));
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
