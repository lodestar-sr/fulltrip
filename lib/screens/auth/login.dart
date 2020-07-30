import 'package:Fulltrip/services/auth.service.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:Fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginFormKey = GlobalKey<FormState>();
  final forgotFormKey = GlobalKey<FormState>();
  bool absure = true;
  String _email;
  String _password;
  String _forgotEmail;

  AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService.getInstance();
    SharedPreferences.getInstance().then((value) {
      Global.prefs = value;
      if (_authService.isLoggedIn()) {
        Navigator.of(context).pushReplacementNamed('dashboard');
      }
    });
  }

  onSubmit() {
    if (loginFormKey.currentState.validate()) {
      final form = loginFormKey.currentState;
      form.save();
      setState(() => Global.isLoading = true);
      context.read<FirebaseAuthService>().signInWithEmailAndPassword(email: _email, password: _password).then((user) {
        setState(() => Global.isLoading = false);
//        if (user.isEmailVerified != null && user.isEmailVerified) {
        _authService.updateUser(user: user);
        Navigator.of(context).pushNamedAndRemoveUntil('dashboard', (Route<dynamic> route) => false);
//        } else {
//          showDialog(
//            context: context,
//            builder: (context) {
//              return AlertDialog(
//                content: Text('Email is not activated. Please verify your email'),
//              );
//            },
//          );
//        }
      }).catchError((error) {
        setState(() => Global.isLoading = false);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.message),
            );
          },
        );
      });
    }
  }

  sendResetEmail() {
    if (forgotFormKey.currentState.validate()) {
      final form = forgotFormKey.currentState;
      form.save();

      Navigator.of(context).pop();
      setState(() => Global.isLoading = true);
      context.read<FirebaseAuthService>().resetPassword(_forgotEmail).then((value) {
        setState(() => Global.isLoading = false);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Reset password email is sent'),
            );
          },
        );
      }).catchError((error) {
        setState(() => Global.isLoading = false);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.message),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 32, 16, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8, top: 16),
                          width: double.infinity,
                          child: Text('Se connecter', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppColors.darkColor)),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Row(
                            children: [
                              Text('Vous n\'avez pas de compte? ', style: AppStyles.greyTextStyle),
                              GestureDetector(
                                child: Text(' Enregistrement', style: AppStyles.primaryTextStyle),
                                onTap: () {
                                  Navigator.of(context).pushNamed('register');
                                },
                              ),
                            ],
                          ),
                        ),
                        Form(
                          key: loginFormKey,
                          //autovalidate: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  initialValue: '',
                                  decoration: hintTextDecoration('Votre email').copyWith(suffixIcon: Icon(Icons.check, color: AppColors.primaryColor)),
                                  validator: (value) => Validators.mustEmail(value, errorText: 'Veuillez saisir votre email valide'),
                                  keyboardType: TextInputType.emailAddress,
                                  style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
                                  onSaved: (val) => setState(() => _email = val),
                                ),
                              ),
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  decoration: hintTextDecoration('Mot de passe')
                                      .copyWith(suffixIcon: IconButton(icon: absure ? Icon(Icons.visibility_off) : Icon(Icons.visibility), onPressed: () => setState(() => absure = !absure))),
                                  validator: (value) => Validators.required(value, errorText: 'Veuillez saisir votre mot de passe'),
                                  keyboardType: TextInputType.text,
                                  obscureText: absure,
                                  style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
                                  onSaved: (val) => setState(() => _password = val),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: GestureDetector(
                                  child: Text('Mot de passe oublié?', style: AppStyles.primaryTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Mot de passe oublié?'),
                                          content: Form(
                                            key: forgotFormKey,
                                            child: FormFieldContainer(
                                              padding: EdgeInsets.all(4),
                                              child: TextFormField(
                                                initialValue: '',
                                                decoration: hintTextDecoration('Email'),
                                                validator: (value) => Validators.mustEmail(value, errorText: 'Veuillez saisir votre email valide'),
                                                keyboardType: TextInputType.emailAddress,
                                                style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
                                                onSaved: (val) => setState(() => _forgotEmail = val),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            RaisedButton(
                                              child: Text('Envoyer', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                              color: AppColors.primaryColor,
                                              onPressed: sendResetEmail,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 32, bottom: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(color: AppColors.primaryColor.withOpacity(0.24), blurRadius: 16, spreadRadius: 4),
                                  ],
                                ),
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 56,
                                  child: RaisedButton(
                                    child: Text('Se connecter', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                    color: AppColors.primaryColor,
                                    textColor: Colors.white,
                                    onPressed: onSubmit,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    elevation: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Text("OU", style: AppStyles.greyTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                        OutlineButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                          padding: EdgeInsets.all(16),
                          highlightedBorderColor: AppColors.greyColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/google.png', width: 16),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text('Se connecter avec Google', style: AppStyles.darkGreyTextStyle.copyWith(fontSize: 14)),
                              )
                            ],
                          ),
                          onPressed: () {
                            setState(() => Global.isLoading = true);
                            context.read<FirebaseAuthService>().signInWithGoogle().then((user) {
                              setState(() => Global.isLoading = false);
                              Navigator.of(context).pushNamedAndRemoveUntil('dashboard', (Route<dynamic> route) => false);
                            }).catchError((error) {
                              setState(() => Global.isLoading = false);
                            });
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16, bottom: 64),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(16),
                            color: Colors.black,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesome.apple,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text('Se connecter avec Apple', style: AppStyles.darkGreyTextStyle.copyWith(fontSize: 14, color: Colors.white)),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() => Global.isLoading = true);
                              context.read<FirebaseAuthService>().signInWithGoogle().then((user) {
                                setState(() => Global.isLoading = false);
                                Navigator.of(context).pushNamedAndRemoveUntil('dashboard', (Route<dynamic> route) => false);
                              }).catchError((error) {
                                setState(() => Global.isLoading = false);
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 32),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(text: 'En vous inscrivant, vous acceptez les règles énoncées dans la ', style: AppStyles.greyTextStyle.copyWith(fontSize: 13), children: [
                              TextSpan(
                                text: 'Politique de confidentialité',
                                style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
                              ),
                              TextSpan(
                                text: ' et ',
                                style: AppStyles.greyTextStyle.copyWith(fontSize: 13),
                              ),
                              TextSpan(
                                text: 'les règles de service.',
                                style: AppStyles.primaryTextStyle.copyWith(fontSize: 13),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
