import 'package:Fulltrip/data/models/user.dart';
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

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final registerFormKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _name;
  String _phone;

  onSubmit() {
    if (registerFormKey.currentState.validate()) {
      final form = registerFormKey.currentState;
      form.save();

      setState(() => Global.isLoading = true);
      context.read<FirebaseAuthService>().createWithEmailAndPassword(email: _email, password: _password, name: _name, phone: _phone).then((user) {
        setState(() => Global.isLoading = false);
        Navigator.of(context).pushNamed('verify-sms', arguments: <String, User>{'user': user});
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
                    padding: EdgeInsets.fromLTRB(16, 60, 16, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 54),
                          width: double.infinity,
                          child: Center(
                            child: Text('Commençons', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.greyDarkColor)),
                          ),
                        ),
                        Form(
                          key: registerFormKey,
                          autovalidate: true,
                          child: Column(
                            children: [
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  initialValue: '',
                                  decoration: hintTextDecoration('Nom de l\'entreprise').copyWith(prefixIcon: Icon(Icons.person_outline)),
                                  validator: (value) => Validators.required(value, errorText: 'Veuillez saisir nom de l\'entreprise'),
                                  keyboardType: TextInputType.text,
                                  style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
                                  onSaved: (val) => setState(() => _name = val),
                                ),
                              ),
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  initialValue: '',
                                  decoration: hintTextDecoration('Numéro de téléphone').copyWith(prefixIcon: Icon(Feather.smartphone)),
                                  validator: (value) => Validators.mustNumeric(value, errorText: 'Veuillez saisir un numéro de téléphone valide'),
                                  keyboardType: TextInputType.phone,
                                  style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
                                  onSaved: (val) => setState(() => _phone = val),
                                ),
                              ),
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  initialValue: '',
                                  decoration: hintTextDecoration('Sähköposti').copyWith(prefixIcon: Icon(Icons.mail_outline)),
                                  validator: (value) => Validators.mustEmail(value, errorText: 'Veuillez saisir votre email valide'),
                                  keyboardType: TextInputType.emailAddress,
                                  style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
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
                                  style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
                                  onSaved: (val) => setState(() => _password = val),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 98, bottom: 32),
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
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Vous avez déjà un compte? ', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                                    GestureDetector(
                                      child: Text(' Se connecter', style: AppStyles.primaryTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
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
