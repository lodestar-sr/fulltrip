import 'package:Fulltrip/data/models/ChatModel.dart';
import 'package:Fulltrip/data/models/DistanceTimeModel.dart';
import 'package:Fulltrip/data/models/Messages.dart';
import 'package:Fulltrip/data/models/filter.dart';
import 'package:Fulltrip/data/models/lot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static bool isLoading = false;
  static String address = '';
  static GoogleSignIn googleSignIn;
  static FirebaseAuth auth;
  static FirebaseStorage storage;
  static Firestore firestore;
  static Lot lotForm;
  static Filter filter = Filter();
  static SharedPreferences prefs;

  static List<ChatModel> chatmessages = [
    ChatModel(message: 'Bonne journée! Je veux en savoir plus sur votre entreprise et depuis combien de temps êtes-vous sur le marché du transport?', id: 0),
    ChatModel(message: 'Hey! Notre entreprise est engagée dans le transport depuis 2001', id: 1),
    ChatModel(message: 'Bonne journée! Je veux en savoir plus sur votre entreprise et depuis combien de temps êtes-vous sur le marché du transport?', id: 0),
    ChatModel(message: 'Hey! Notre entreprise est engagée dans le transport depuis 2001', id: 1),
    ChatModel(message: 'Bonne journée! Je veux en savoir plus sur votre entreprise et depuis combien de temps êtes-vous sur le marché du transport?', id: 0),
    ChatModel(message: 'Hey! Notre entreprise est engagée dans le transport depuis 2001', id: 1),
  ];
  static List<Messages> usermessages = [
    Messages(name: 'WCR', message: 'Thank You', time: DateTime(2017, 9, 7, 17, 30), unread: 8, status: 'online', photo: ''),
    Messages(name: 'WCR', message: 'Thank You', time: DateTime(2017, 9, 7, 17, 30), unread: 8, status: 'online', photo: ''),
    Messages(name: 'WCR', message: 'Thank You', time: DateTime(2017, 9, 7, 17, 30), unread: 8, status: 'online', photo: ''),
    Messages(name: 'WCR', message: 'Thank You', time: DateTime(2017, 9, 7, 17, 30), unread: 9, status: 'online', photo: ''),
    Messages(name: 'WCR', message: 'Thank You', time: DateTime(2017, 9, 7, 17, 30), unread: 3, status: 'online', photo: ''),
    Messages(name: 'WCR', message: 'Thank You', time: DateTime(2017, 9, 7, 17, 30), unread: 7, status: 'offline', photo: ''),
    Messages(name: 'WCR', message: 'Thank You', time: DateTime(2017, 9, 7, 17, 30), unread: 5, status: 'offline', photo: ''),
  ];

  static Future<Map> calculateDistance({String startingAddress, String arrivalAddress}) async {
    List startinglatlong = [];
    List arrivallatlong = [];

    try {
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
            'distanceinKm': element.distance == null ? 0 : element.distance.value / 1000,
            'duration': element.duration == null ? '' : element.duration.text,
          };
        } else {
          return {
            'distanceinKm': 0,
            'duration': 'Undefined',
          };
        }
      });
    } catch (e) {
      print(e);
      return {
        'distanceinKm': 0,
        'duration': 'Undefined',
      };
    }
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
  static List<String> profileOptions = [
    'Mes informations',
    'Coordonnées bancaires',
    'Transaction en cours',
    'Historique de transport',
    'Mes factures',
    'Mes documents',
    'Nous contacter',
    'Se déconnecter',
  ];
  static List profileIcons = [
    Feather.user,
    FontAwesome.window_maximize,
    Feather.loader,
    FontAwesome.history,
    MaterialIcons.euro_symbol,
    FontAwesome.folder,
    FontAwesome.envelope,
    Octicons.sign_out,
  ];
  static List<String> typedelieu = [
    '',
    'Immeuble',
    'Maison',
    'Garde-meubles',
    'Entrepôt',
    'Magasin',
  ];
  static List<String> typedeacces = [
    '',
    'Plein pieds',
    'Ascenseur',
    'Escaliers',
  ];
  static List<String> etages = [
    '',
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
