import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/util/validators/validators.dart';
import 'package:fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginFormKey = GlobalKey<FormState>();

  String _email;
  String _password;

  onSubmit() {
    if (loginFormKey.currentState.validate()) {
      final form = loginFormKey.currentState;
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.greenColor,
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
                    padding: EdgeInsets.fromLTRB(16, 60, 16, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          width: double.infinity,
                          child: Center(
                            child: Text('Bienvenue sur Full Trip', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.greyDarkColor)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 28),
                          width: double.infinity,
                          child: Center(
                            child: Text('Connectez-vous pour continuer', style: TextStyle(fontSize: 12, color: AppColors.greyColor)),
                          ),
                        ),Form(
                          key: loginFormKey,
                          child: Column(
                            children: [
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  initialValue: '',
                                  decoration: hintTextDecoration('Votre email').copyWith(prefixIcon: Icon(Icons.mail_outline)),
                                  validator: (value) => Validators.mustEmail(value, errorText: 'Veuillez saisir votre email valide'),
                                  keyboardType: TextInputType.emailAddress,
                                  style: AppStyles.greyTextStyle.copyWith(fontSize: 18),
                                  onSaved: (val) => setState(() => _email = val),
                                ),
                              ),
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  decoration: hintTextDecoration('Mot de passe').copyWith(prefixIcon: Icon(Icons.lock_outline)),
                                  validator: (value) => Validators.required(value, errorText: 'Veuillez saisir votre mot de passe'),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  style: AppStyles.greyTextStyle.copyWith(fontSize: 18),
                                  onSaved: (val) => setState(() => _password = val),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 16, bottom: 32),
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
                                    child: Text('Appliquer les filtres', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
                            child: Text("OU", style: AppStyles.greyTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                          Expanded(
                            child: Divider(color: AppColors.lightGreyColor),
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          child: Text('Ou connectez-vous avec', style: AppStyles.greyTextStyle.copyWith(fontSize: 14)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16, bottom: 24),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFDD4B39)),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Image.asset('assets/images/google.png', width: 16),
                        ),
                        Container(
                          child: GestureDetector(child: Text('Mot de passe oublié?', style: AppStyles.primaryTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold)), onTap: () {}),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Vous n\'avez pas de compte? ', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                              GestureDetector(child: Text(' Enregistrement', style: AppStyles.primaryTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold)), onTap: () {}),
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
