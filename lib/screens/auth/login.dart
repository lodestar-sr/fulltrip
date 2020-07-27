import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:Fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginFormKey = GlobalKey<FormState>();
  bool absure = true;
  String _email;
  String _password;

  onSubmit() {
    if (loginFormKey.currentState.validate()) {
      final form = loginFormKey.currentState;
      form.save();
      setState(() => Global.isLoading = true);
      context
          .read<FirebaseAuthService>()
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        setState(() => Global.isLoading = false);
        if (user.isEmailVerified != null && user.isEmailVerified) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              'dashboard', (Route<dynamic> route) => false);
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content:
                    Text('Email is not activated. Please verify your email'),
              );
            },
          );
        }
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
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
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
                          child:
                              Image.asset('assets/images/icon.png', width: 98),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8, top: 32),
                          width: double.infinity,
                          child: Center(
                            child: Text('Bienvenue sur Full Trip',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.greyDarkColor)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 28),
                          width: double.infinity,
                          child: Center(
                            child: Text('Connectez-vous pour continuer',
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.greyColor)),
                          ),
                        ),
                        Form(
                          key: loginFormKey,
                          //autovalidate: true,
                          child: Column(
                            children: [
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  initialValue: '',
                                  decoration: hintTextDecoration('Votre email')
                                      .copyWith(
                                          prefixIcon: Icon(Icons.mail_outline)),
                                  validator: (value) => Validators.mustEmail(
                                      value,
                                      errorText:
                                          'Veuillez saisir votre email valide'),
                                  keyboardType: TextInputType.emailAddress,
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontSize: 18),
                                  onSaved: (val) =>
                                      setState(() => _email = val),
                                ),
                              ),
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  decoration: hintTextDecoration('Mot de passe')
                                      .copyWith(
                                          prefixIcon: Icon(Icons.lock_outline),
                                          suffixIcon: IconButton(
                                              icon: absure
                                                  ? Icon(Icons.visibility_off)
                                                  : Icon(Icons.visibility),
                                              onPressed: () => setState(
                                                  () => absure = !absure))),
                                  validator: (value) => Validators.required(
                                      value,
                                      errorText:
                                          'Veuillez saisir votre mot de passe'),
                                  keyboardType: TextInputType.text,
                                  obscureText: absure,
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontSize: 18),
                                  onSaved: (val) =>
                                      setState(() => _password = val),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 16, bottom: 32),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.24),
                                        blurRadius: 16,
                                        spreadRadius: 4),
                                  ],
                                ),
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 56,
                                  child: RaisedButton(
                                    child: Text('Appliquer les filtres',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    color: AppColors.primaryColor,
                                    textColor: Colors.white,
                                    onPressed: onSubmit,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            child: Divider(color: AppColors.lightGreyColor),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 24, right: 24),
                            child: Text("OU",
                                style: AppStyles.greyTextStyle.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                          Expanded(
                            child: Divider(color: AppColors.lightGreyColor),
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          child: Text('Ou connectez-vous avec',
                              style: AppStyles.greyTextStyle
                                  .copyWith(fontSize: 14)),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 16, bottom: 24),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFDD4B39)),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Image.asset('assets/images/google.png',
                                width: 16),
                          ),
                          onTap: () {
                            setState(() => Global.isLoading = true);
                            context
                                .read<FirebaseAuthService>()
                                .signInWithGoogle()
                                .then((user) {
                              setState(() => Global.isLoading = false);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'dashboard', (Route<dynamic> route) => false);
                            }).catchError((error) {
                              setState(() => Global.isLoading = false);
                            });
                          },
                        ),
                        Container(
                          child: GestureDetector(
                            child: Text('Mot de passe oublié?',
                                style: AppStyles.primaryTextStyle.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            onTap: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Vous n\'avez pas de compte? ',
                                  style: AppStyles.greyTextStyle
                                      .copyWith(fontSize: 12)),
                              GestureDetector(
                                child: Text(' Enregistrement',
                                    style: AppStyles.primaryTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  Navigator.of(context).pushNamed('register');
                                },
                              ),
                            ],
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
