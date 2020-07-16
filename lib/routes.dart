import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/screens/auth/login.dart';
import 'package:fulltrip/screens/auth/register.dart';
import 'package:fulltrip/screens/auth/verify_sms.dart';
import 'package:fulltrip/screens/dashboard/dashboard.dart';
import 'package:fulltrip/screens/home/filter/filter.dart';
import 'package:fulltrip/screens/home/home.dart';
import 'package:fulltrip/screens/home/lot_details/lot_details.dart';
import 'package:fulltrip/screens/home/propose_lot/propose_lot.dart';
import 'package:fulltrip/screens/profil/Profil.dart';
import 'package:fulltrip/screens/splash/splash.dart';
import 'package:fulltrip/util/global.dart';
import 'screens/home/propose_lot/Felicitations.dart';
import 'screens/home/propose_lot/propose_lot3.dart';
import 'screens/home/propose_lot/propose_lot2.dart';
import 'screens/profil/MesDocuments/Mes_Documents.dart';
import 'screens/profil/informations/CoordoneedBancaires/CoordonneesBancaries.dart';
import 'screens/profil/informations/HelpCenter/CentreDaide.dart';
import 'screens/profil/informations/Mes_information/AdresseDuSiege.dart';
import 'screens/profil/informations/Mes_information/Mes_Informations.dart';
import 'screens/profil/informations/Mes_information/RaisonSociale.dart';
import 'screens/profil/informations/Mes_information/changePassword.dart';
import 'screens/profil/informations/Mes_information/emailOption.dart';
import 'screens/profil/informations/Mes_information/telephoneoption.dart';
import 'screens/profil/informations/TransactionEnCours/TransactionEnCours.dart';
import 'screens/profil/informations/TransactionEnCours/TransactionInformation.dart';
import 'screens/profil/informations/Transport history/DetailsDuVoyage.dart';
import 'screens/profil/informations/Transport history/HistoriqueTransport.dart';
import 'util/theme.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    'splash': (BuildContext context) => Splash(),
    'login': (BuildContext context) => Login(),
    'register': (BuildContext context) => Register(),
    'verify-sms': (BuildContext context) => VerifySMS(),
    'dashboard': (BuildContext context) => Dashboard(),
    'home': (BuildContext context) => Home(),
    'filter': (BuildContext context) => Filter(),
    'lot-details': (BuildContext context) => LotDetails(),
    'propose-lot': (BuildContext context) => ProposeLot(),
    'ProposeLot2': (BuildContext context) => ProposeLot2(),
    'ProposeLot3': (BuildContext context) => ProposeLot3(),
    'Felicitations': (BuildContext context) => Felicitations(),
    'Profil': (BuildContext context) => Profil(),
    'mes_informations': (BuildContext context) => Mes_Informations(),
    'raisonsociale': (BuildContext context) => RaisonSociale(),
    'emailoption': (BuildContext context) => EmailOption(),
    'telephoneoption': (BuildContext context) => TelephoneOption(),
    'changepassword': (BuildContext context) => ChangePassword(),
    'adressedusiege': (BuildContext context) => AdresseDuSiege(),
    'CoordonneesBancaries': (BuildContext context) => CoordonneesBancaries(),
    'transactionencours': (BuildContext context) => TransactionEnCours(),
    'transactioninformation': (BuildContext context) =>
        TransactionInformation(),
    'centredaide': (BuildContext context) => CentreDaide(),
    'historiqueinformation': (BuildContext context) => HistoriqueInformation(),
    'detailsduvage': (BuildContext context) => DetailsDuVage(),
    'mesdocuments': (BuildContext context) => MesDocuments(),
  };

  Routes({FirebaseStorage storage, Firestore firestore}) {
    Global.storage = storage;
    Global.firestore = firestore;
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abonnements',
      theme: appTheme(),
      routes: routes,
      home: Splash(),
    ));
  }
}
