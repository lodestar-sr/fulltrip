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
