import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/screens/auth/login.dart';
import 'package:Fulltrip/screens/auth/register.dart';
import 'package:Fulltrip/screens/auth/verify_sms.dart';
import 'package:Fulltrip/screens/dashboard/dashboard.dart';
import 'package:Fulltrip/screens/home/CloseToYou/CloseToYou.dart';
import 'package:Fulltrip/screens/home/CloseToYou/Liste.dart';
import 'package:Fulltrip/screens/home/filter/filter.dart';
import 'package:Fulltrip/screens/home/home.dart';
import 'package:Fulltrip/screens/lot/lot_reservation.dart';
import 'package:Fulltrip/screens/home/propose_lot/payment_method/payment_method.dart';
import 'package:Fulltrip/screens/home/propose_lot/propose_lot.dart';
import 'package:Fulltrip/screens/map_street/map_street.dart';
import 'package:Fulltrip/screens/lot/lot_details.dart';
import 'package:Fulltrip/screens/profile/documents/documents.dart';
import 'package:Fulltrip/screens/profile/informations/Transport_history/DetailsDuVoyage.dart';
import 'package:Fulltrip/screens/profile/informations/Transport_history/HistoriqueTransport.dart';
import 'package:Fulltrip/screens/profile/profile.dart';
import 'package:Fulltrip/screens/lot/lot_validation.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'screens/home/CloseToYou/Carte.dart';
import 'screens/lot/success_screen.dart';
import 'screens/home/propose_lot/Felicitations.dart';
import 'screens/home/propose_lot/propose_lot2.dart';
import 'screens/home/propose_lot/propose_lot3.dart';
import 'screens/home/propose_lot/propose_lot4.dart';
import 'screens/updates/messages_tab/chat_messages.dart';
import 'screens/updates/messages_tab/messages_tab.dart';
import 'screens/profile/announcements/announcements.dart';
import 'screens/profile/transport/transport.dart';
import 'screens/profile/informations/CoordoneedBancaires/CoordonneesBancaries.dart';
import 'screens/profile/informations/HelpCenter/CentreDaide.dart';
import 'screens/profile/informations/TransactionEnCours/TransactionEnCours.dart';
import 'screens/profile/informations/TransactionEnCours/TransactionInformation.dart';
import 'screens/profile/informations/informations/Informations.dart';
import 'screens/profile/informations/informations/change_address.dart';
import 'screens/profile/informations/informations/change_email.dart';
import 'screens/profile/informations/informations/change_password.dart';
import 'screens/profile/informations/informations/change_phone.dart';
import 'screens/profile/informations/informations/commanditaire.dart';
import 'screens/profile/informations/informations/raison_sociale.dart';
import 'screens/splash/splash.dart';
import 'util/theme.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    'splash': (BuildContext context) => Splash(),
    'login': (BuildContext context) => Login(),
    'register': (BuildContext context) => Register(),
    'verify-sms': (BuildContext context) => VerifySMS(),
    'map-street': (BuildContext context) => MapStreet(),
    'dashboard': (BuildContext context) => Dashboard(),
    'home': (BuildContext context) => Home(),
    'filter': (BuildContext context) => Filter(),
    'propose-lot': (BuildContext context) => ProposeLot(),
    'ProposeLot2': (BuildContext context) => ProposeLot2(),
    'ProposeLot3': (BuildContext context) => ProposeLot3(),
    'ProposeLot4': (BuildContext context) => ProposeLot4(),
    'MeansOfPayment': (BuildContext context) => PaymentMethod(),
    'Felicitations': (BuildContext context) => Felicitations(),
    'profile': (BuildContext context) => Profile(),
    'mes_informations': (BuildContext context) => Informations(),
    'raisonsociale': (BuildContext context) => RaisonSociale(),
    'emailoption': (BuildContext context) => ChangeEmail(),
    'telephoneoption': (BuildContext context) => ChangePhone(),
    'changepassword': (BuildContext context) => ChangePassword(),
    'adressedusiege': (BuildContext context) => ChangeAddress(),
    'CoordonneesBancaries': (BuildContext context) => CoordonneesBancaries(),
    'transactionencours': (BuildContext context) => TransactionEnCours(),
    'transactioninformation': (BuildContext context) =>
        TransactionInformation(),
    'centredaide': (BuildContext context) => CentreDaide(),
    'historiqueinformation': (BuildContext context) => HistoriqueInformation(),
    'detailsduvage': (BuildContext context) => DetailsDuVage(),
    'mesdocuments': (BuildContext context) => Documents(),
    'MessageScreen': (BuildContext context) => MessagesTab(),
    'ChatMessages': (BuildContext context) => ChatMessages(),
    'Commanditaire': (BuildContext context) => Commanditaire(),
    'Announces': (BuildContext context) => Announces(),
    'TransPort': (BuildContext context) => Transport(),
    'lot-reservation': (BuildContext context) => LotReservation(),
    'lot-validation': (BuildContext context) => LotValidation(),
    'lot-details': (BuildContext context) => LotDetails(),
    'success-screen': (BuildContext context) => SuccessScreen(),
    'closetoyou': (BuildContext context) => CloseToYou(),
    'Carte': (BuildContext context) => Carte(),
    'Liste': (BuildContext context) => Liste(),
  };

  Routes({
    FirebaseStorage storage,
    Firestore firestore,
    FirebaseAuth auth,
    GoogleSignIn googleSignIn,
  }) {
    Global.storage = storage;
    Global.firestore = firestore;
    Global.googleSignIn = googleSignIn;
    Global.auth = auth;
    runApp(MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuthService()),
        StreamProvider(
            create: (context) =>
                context.read<FirebaseAuthService>().onAuthStateChanged),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fulltrip',
        theme: appTheme(),
        routes: routes,
        home: Splash(),
      ),
    ));
  }
}
