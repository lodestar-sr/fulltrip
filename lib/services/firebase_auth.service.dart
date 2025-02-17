import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? Global.auth,
        _googleSignIn = googleSignin ?? Global.googleSignIn;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      photoUrl: user.photoUrl ?? '',
      phone: user.phoneNumber ?? '',
      isEmailVerified: user.isEmailVerified,
    );
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> createWithEmailAndPassword({String email, String password}) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await authResult.user.sendEmailVerification();
    return _userFromFirebase(authResult.user);
  }

  Future<User> signInWithEmailAndPassword({String email, String password}) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  Future<void> verifyPhone({String number, onCompleted, onFailed, onCodeSent}) {
    return Global.auth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential phoneAuthCredential) {
          onCompleted(phoneAuthCredential);
        },
        verificationFailed: (AuthException exceptio) {
          onFailed(exceptio.message);
        },
        codeSent: (String verId, [int forceCodeResend]) {
          onCodeSent(verId);
        },
        codeAutoRetrievalTimeout: (String verId) {
          print('codeAutoRetrievalTimeout: ' + verId);
        });
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateEmail(String email) async {
    final user = await _firebaseAuth.currentUser();
    return user.updateEmail(email);
  }

  Future<void> updatePassword(String password) async {
    final user = await _firebaseAuth.currentUser();
    return user.updatePassword(password);
  }
}
