import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fulltrip/data/models/filter.dart';
import 'package:fulltrip/data/models/lot.dart';

class Global {
  static bool isLoading = false;
  static String address = '';
  static FirebaseStorage storage;
  static Firestore firestore;
  static Lot lotForm;
  static Filter filter = Filter();
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
    {
      "companyname": "Company name",
      "startcity": "Paris,France",
      "startAdd": "40 Avenue Leon Blum",
      "arrivalcity": "Nice,France",
      "arrivalAdd": "2-6 Rue Joseph d'Arbuad",
      "price": "500",
      "delivery": "Luxe",
      "volume": "50"
    }
  ];
  static List<String> profileoptions = [
    'Mes informations',
    'Coordonnées bancaires',
    'Transaction en cours',
    'Historique de transport',
    'Mes factures',
    'Mes documents'
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
