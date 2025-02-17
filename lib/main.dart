import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: FirebaseOptions(
      googleAppID: (Platform.isIOS || Platform.isMacOS)
          ? '1:77728748956:ios:cf993569f0756fa3a5e459'
          : '1:77728748956:android:51a2eab083f25272a5e459',
      gcmSenderID: '77728748956',
      apiKey: 'AIzaSyA1bL0g3QQatTU161FYTNr8sujJBqkXUkw',
      projectID: 'fulltrip',
    ),
  );

  final FirebaseStorage storage = FirebaseStorage(
    app: app,
    storageBucket: 'gs://fulltrip.appspot.com',
  );
  final Firestore firestore = Firestore(app: app);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  new Routes(
    storage: storage,
    firestore: firestore,
    auth: auth,
    googleSignIn: googleSignIn,
  );
}
