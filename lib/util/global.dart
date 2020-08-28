import 'package:Fulltrip/data/models/chat.model.dart';
import 'package:Fulltrip/data/models/distance_time.model.dart';
import 'package:Fulltrip/data/models/message.model.dart';
import 'package:Fulltrip/data/models/filter.model.dart';
import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  static int updatesTabIndex = 0;
  static int annoncesTabIndex = 0;
  static int transportTabIndex = 0;
  static int initialindex = 0;
  static String searchTitle = '';
  static List<Lot> customSearch = [];
  static List<ChatModel> chatMessages = [
    ChatModel(
        message:
            'Bonne journée! Je veux en savoir plus sur votre entreprise et depuis combien de temps êtes-vous sur le marché du transport?',
        id: 0),
    ChatModel(
        message:
            'Hey! Notre entreprise est engagée dans le transport depuis 2001',
        id: 1),
    ChatModel(
        message:
            'Bonne journée! Je veux en savoir plus sur votre entreprise et depuis combien de temps êtes-vous sur le marché du transport?',
        id: 0),
    ChatModel(
        message:
            'Hey! Notre entreprise est engagée dans le transport depuis 2001',
        id: 1),
    ChatModel(
        message:
            'Bonne journée! Je veux en savoir plus sur votre entreprise et depuis combien de temps êtes-vous sur le marché du transport?',
        id: 0),
    ChatModel(
        message:
            'Hey! Notre entreprise est engagée dans le transport depuis 2001',
        id: 1),
    ChatModel(
        message:
            'Bonne journée! Je veux en savoir plus sur votre entreprise et depuis combien de temps êtes-vous sur le marché du transport?',
        id: 0),
    ChatModel(
        message:
            'Bonne journée! Je veux en savoir plus sur votre entreprise et depuis combien de temps êtes-vous sur le marché du transport?',
        id: 0),
  ];

  static List<Message> userMessages = [
    Message(
        name: 'WCR',
        message:
            'Thank You fdsfdsf dfs fsdf sf f f f f f f f f fdfs fsdf dsf sdfds fsdf sdf sf sdf sdf dsfsd fdsf dsf sdf sd  fds fsd fsd fsdfsfsf sdfsdf',
        time: DateTime(2017, 9, 7, 17, 30),
        unread: 8,
        status: 'online',
        photo: ''),
    Message(
        name: 'WCR',
        message: 'Thank You',
        time: DateTime(2017, 9, 7, 17, 30),
        unread: 8,
        status: 'online',
        photo: ''),
    Message(
        name: 'WCR',
        message: 'Thank You',
        time: DateTime(2017, 9, 7, 17, 30),
        unread: 8,
        status: 'online',
        photo: ''),
    Message(
        name: 'WCR',
        message: 'Thank You',
        time: DateTime(2017, 9, 7, 17, 30),
        unread: 9,
        status: 'online',
        photo: ''),
    Message(
        name: 'WCR',
        message: 'Thank You',
        time: DateTime(2017, 9, 7, 17, 30),
        unread: 3,
        status: 'online',
        photo: ''),
    Message(
        name: 'WCR',
        message: 'Thank You',
        time: DateTime(2017, 9, 7, 17, 30),
        unread: 7,
        status: 'offline',
        photo: ''),
    Message(
        name: 'WCR',
        message: 'Thank You',
        time: DateTime(2017, 9, 7, 17, 30),
        unread: 5,
        status: 'offline',
        photo: ''),
  ];

  static Future<Map> calculateDistance(
      {String startingAddress, String arrivalAddress}) async {
    List startinglatlong = [];
    List arrivallatlong = [];

    try {
      //Start
      List<Placemark> startingAddressPlacemark =
          await Geolocator().placemarkFromAddress(startingAddress);
      Placemark startingPlace = startingAddressPlacemark[0];
      startinglatlong = [
        startingPlace.position.latitude,
        startingPlace.position.longitude
      ];
      //Arrival
      List<Placemark> arrivalAddressPlacemark =
          await Geolocator().placemarkFromAddress(arrivalAddress);
      Placemark arrivalPlace = arrivalAddressPlacemark[0];
      arrivallatlong = [
        arrivalPlace.position.latitude,
        arrivalPlace.position.longitude
      ];

      return fetchRequestGoogleApi(startinglatlong[0], startinglatlong[1],
              arrivallatlong[0], arrivallatlong[1])
          .then((value) {
        if (value.status == 'OK') {
          var rows = value.rows;
          var element = rows[0].elements[0];
          return {
            'distanceinKm':
                element.distance == null ? 0.0 : element.distance.value / 1000,
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

  static List<Lot> proposedLots = [];
  static List<Lot> reservedLots = [];
  static List<Map> transportHistory = [
    {
      "date": "30 juin 2020",
      "startcity": "Paris",
      "arrivalcity": "Nice",
      "price": "500"
    },
    {
      "date": "30 juin 2020",
      "startcity": "Paris",
      "arrivalcity": "Nice",
      "price": "500"
    },
    {
      "date": "30 juin 2020",
      "startcity": "Paris",
      "arrivalcity": "Nice",
      "price": "400"
    },
    {
      "date": "30 juin 2020",
      "startcity": "Paris",
      "arrivalcity": "Nice",
      "price": "300"
    },
    {
      "date": "30 juin 2020",
      "startcity": "Paris",
      "arrivalcity": "Nice",
      "price": "600"
    },
    {
      "date": "30 juin 2020",
      "startcity": "Paris",
      "arrivalcity": "Nice",
      "price": "600"
    },
    {
      "date": "30 juin 2020",
      "startcity": "Paris",
      "arrivalcity": "Nice",
      "price": "600"
    },
    {
      "date": "30 juin 2020",
      "startcity": "Paris",
      "arrivalcity": "Nice",
      "price": "600"
    },
    {
      "date": "30 juin 2020",
      "startcity": "Paris",
      "arrivalcity": "Nice",
      "price": "600"
    },
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
    'Informations',
    'Annonces',
    'Transport',
    "Centre d'aide",
    'Contacter Fulltrip',
    'Noter sue le store',
    'À propos',
  ];
  static List profileIcons = [
    Feather.user,
    Feather.bell,
    Feather.truck,
    Icons.info_outline,
    MaterialIcons.email,
    FontAwesome.star,
    Feather.book,
  ];
}
