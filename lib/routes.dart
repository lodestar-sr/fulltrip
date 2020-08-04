import 'package:Fulltrip/screens/auth/login.dart';
import 'package:Fulltrip/screens/auth/register.dart';
import 'package:Fulltrip/screens/auth/verify_sms.dart';
import 'package:Fulltrip/screens/dashboard/dashboard.dart';
import 'package:Fulltrip/screens/home/filter/filter.dart';
import 'package:Fulltrip/screens/home/home.dart';
import 'package:Fulltrip/screens/home/lot_details/lot_details.dart';
import 'package:Fulltrip/screens/home/propose_lot/payment_method/payment_method.dart';
import 'package:Fulltrip/screens/home/propose_lot/propose_lot.dart';
import 'package:Fulltrip/screens/profil/Profil.dart';
import 'package:Fulltrip/screens/profil/informations/Transport_history/DetailsDuVoyage.dart';
import 'package:Fulltrip/screens/profil/informations/Transport_history/HistoriqueTransport.dart';
import 'package:Fulltrip/screens/splash/splash.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'screens/home/lot_details/success_screen.dart';
import 'screens/home/propose_lot/Felicitations.dart';
import 'screens/home/propose_lot/propose_lot2.dart';
import 'screens/home/propose_lot/propose_lot3.dart';
import 'screens/home/propose_lot/propose_lot4.dart';
import 'screens/messages/ChatMessages.dart';
import 'screens/messages/MessagesList.dart';
import 'screens/profil/Announces/Annonces.dart';
import 'screens/profil/MesDocuments/Mes_Documents.dart';
import 'screens/profil/TransPort/TransPort.dart';
import 'screens/profil/informations/CoordoneedBancaires/CoordonneesBancaries.dart';
import 'screens/profil/informations/HelpCenter/CentreDaide.dart';
import 'screens/profil/informations/Mes_information/AdresseDuSiege.dart';
import 'screens/profil/informations/Mes_information/Commanditaire.dart';
import 'screens/profil/informations/Mes_information/Mes_Informations.dart';
import 'screens/profil/informations/Mes_information/RaisonSociale.dart';
import 'screens/profil/informations/Mes_information/changePassword.dart';
import 'screens/profil/informations/Mes_information/emailOption.dart';
import 'screens/profil/informations/Mes_information/telephoneoption.dart';
import 'screens/profil/informations/TransactionEnCours/TransactionEnCours.dart';
import 'screens/profil/informations/TransactionEnCours/TransactionInformation.dart';
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
    'SuccessScreen': (BuildContext context) => SuccessScreen(),
    'propose-lot': (BuildContext context) => ProposeLot(),
    'ProposeLot2': (BuildContext context) => ProposeLot2(),
    'ProposeLot3': (BuildContext context) => ProposeLot3(),
    'ProposeLot4': (BuildContext context) => ProposeLot4(),
    'MeansOfPayment': (BuildContext context) => PaymentMethod(),
    'Felicitations': (BuildContext context) => Felicitations(),
    'Profil': (BuildContext context) => Compte(),
    'mes_informations': (BuildContext context) => Mes_Informations(),
    'raisonsociale': (BuildContext context) => RaisonSociale(),
    'emailoption': (BuildContext context) => EmailOption(),
    'telephoneoption': (BuildContext context) => TelephoneOption(),
    'changepassword': (BuildContext context) => ChangePassword(),
    'adressedusiege': (BuildContext context) => AdresseDuSiege(),
    'CoordonneesBancaries': (BuildContext context) => CoordonneesBancaries(),
    'transactionencours': (BuildContext context) => TransactionEnCours(),
    'transactioninformation': (BuildContext context) => TransactionInformation(),
    'centredaide': (BuildContext context) => CentreDaide(),
    'historiqueinformation': (BuildContext context) => HistoriqueInformation(),
    'detailsduvage': (BuildContext context) => DetailsDuVage(),
    'mesdocuments': (BuildContext context) => MesDocuments(),
    'MessageScreen': (BuildContext context) => MessageScreen(),
    'ChatMessages': (BuildContext context) => ChatMessages(),
    'Commanditaire': (BuildContext context) => Commanditaire(),
    'Announces': (BuildContext context) => Announces(),
    'TransPort': (BuildContext context) => TransPort(),
  };

  Routes({FirebaseStorage storage, Firestore firestore, FirebaseAuth auth, GoogleSignIn googleSignIn}) {
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
          create: (context) => context.read<FirebaseAuthService>().onAuthStateChanged,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fulltrip',
        theme: appTheme(),
        routes: routes,
        home: Login(),
      ),
    ));
  }
}
