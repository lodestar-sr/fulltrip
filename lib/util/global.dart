import 'package:Fulltrip/data/models/DistanceTimeModel.dart';
import 'package:Fulltrip/data/models/filter.dart';
import 'package:Fulltrip/data/models/lot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Global {
  static bool isLoading = false;
  static String address = '';
  static GoogleSignIn googleSignIn;
  static FirebaseAuth auth;
  static FirebaseStorage storage;
  static Firestore firestore;
  static Lot lotForm;
  static Filter filter = Filter();

  static Future<Map> calculateDistance({String startingAddress, String arrivalAddress}) async {
    List startinglatlong = [];
    List arrivallatlong = [];

    //Start
    List<Placemark> startingAddresplacemark = await Geolocator().placemarkFromAddress(startingAddress);
    Placemark startingplace = startingAddresplacemark[0];
    startinglatlong = [startingplace.position.latitude, startingplace.position.longitude];
    //Arrival
    List<Placemark> arrivalAddresplacemark = await Geolocator().placemarkFromAddress(arrivalAddress);
    Placemark arrivalplace = arrivalAddresplacemark[0];
    arrivallatlong = [arrivalplace.position.latitude, arrivalplace.position.longitude];

    return fetchRequestGoogleApi(startinglatlong[0], startinglatlong[1], arrivallatlong[0], arrivallatlong[1]).then((value) {
      if (value.status == 'OK') {
        var rows = value.rows;
        var element = rows[0].elements[0];
        return {
          'distanceinKm': element.distance.value / 1000,
          'duration': element.duration.text,
        };
      } else {
        return {
          'distanceinKm': 0,
          'duration': 'Undefined',
        };
      }
    });
  }

  static List<Map> transportHistory = [
    {"date": "30 juin 2020", "startcity": "Paris", "arrivalcity": "Nice", "price": "500"},
    {"date": "30 juin 2020", "startcity": "Paris", "arrivalcity": "Nice", "price": "500"},
    {"date": "30 juin 2020", "startcity": "Paris", "arrivalcity": "Nice", "price": "400"},
    {"date": "30 juin 2020", "startcity": "Paris", "arrivalcity": "Nice", "price": "300"},
    {"date": "30 juin 2020", "startcity": "Paris", "arrivalcity": "Nice", "price": "600"},
    {"date": "30 juin 2020", "startcity": "Paris", "arrivalcity": "Nice", "price": "600"},
    {"date": "30 juin 2020", "startcity": "Paris", "arrivalcity": "Nice", "price": "600"},
    {"date": "30 juin 2020", "startcity": "Paris", "arrivalcity": "Nice", "price": "600"},
    {"date": "30 juin 2020", "startcity": "Paris", "arrivalcity": "Nice", "price": "600"},
  ];
  static List<Map> demoData = [
    {
      "companyname": "Company name",
      "startcity": "Paris,France",
      "startAdd": "40 Avenue Leon Blum",
      "arrivalcity": "Nice,France",
      "arrivalAdd": "2-6 Rue Joseph d'Arbuad",
      "price": "500",
      "delivery": "Luxe",
      "volume": "50"
    },
    {
      "companyname": "Company name",
      "startcity": "Paris,France",
      "startAdd": "40 Avenue Leon Blum",
      "arrivalcity": "Nice,France",
      "arrivalAdd": "2-6 Rue Joseph d'Arbuad",
      "price": "500",
      "delivery": "Luxe",
      "volume": "50"
    },
    {
      "companyname": "Company name",
      "startcity": "Paris,France",
      "startAdd": "40 Avenue Leon Blum",
      "arrivalcity": "Nice,France",
      "arrivalAdd": "2-6 Rue Joseph d'Arbuad",
      "price": "500",
      "delivery": "Luxe",
      "volume": "50"
    },
  ];
  static List<String> profileoptions = [
    'Mes informations',
    'Coordonnées bancaires',
    'Transaction en cours',
    'Historique de transport',
    'Mes factures',
    'Mes documents',
  ];
  static List<String> typedelieu = [
    'Immeuble',
    'Maison',
    'Garde-meubles',
    'Entrepôt',
    'Magasin',
  ];
  static List<String> typedeacces = [
    'Plein',
    'pieds',
    'Ascenseur',
    'Escaliers',
  ];
  static List<String> etages = [
    'RDC',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
}
