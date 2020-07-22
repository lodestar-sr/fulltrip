import 'package:Fulltrip/screens/auth/login.dart';
import 'package:Fulltrip/screens/auth/register.dart';
import 'package:Fulltrip/screens/auth/verify_sms.dart';
import 'package:Fulltrip/screens/dashboard/dashboard.dart';
import 'package:Fulltrip/screens/home/filter/filter.dart';
import 'package:Fulltrip/screens/home/home.dart';
import 'package:Fulltrip/screens/home/lot_details/lot_details.dart';
import 'package:Fulltrip/screens/home/propose_lot/propose_lot.dart';
import 'package:Fulltrip/screens/profil/Profil.dart';
import 'package:Fulltrip/screens/splash/splash.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'screens/messages/MessagesList.dart';
import 'screens/messages/ChatMessages.dart';
import 'screens/home/propose_lot/Felicitations.dart';
import 'screens/home/propose_lot/propose_lot2.dart';
import 'screens/home/propose_lot/propose_lot3.dart';
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
    'MessageScreen': (BuildContext context) => MessageScreen(),
    'ChatMessages': (BuildContext context) => ChatMessages(),
  };

  Routes(
      {FirebaseStorage storage,
      Firestore firestore,
      FirebaseAuth auth,
      GoogleSignIn googleSignIn}) {
    Global.storage = storage;
    Global.firestore = firestore;
    Global.googleSignIn = googleSignIn;
    Global.auth = auth;
    runApp(MultiProvider(
      providers: [
        Provider(
          create: (_) => FirebaseAuthService(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthService>().onAuthStateChanged,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fulltrip',
        theme: appTheme(),
        routes: routes,
        home: Dashboard(),
      ),
    ));
  }
}
