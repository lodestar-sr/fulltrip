import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:Fulltrip/widgets/form_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String _confirmPassword;
  String _raisonSociale;
  String _phone;
  bool absure = true;

  bool raisonAutoValidate = false;
  bool phoneAutoValidate = false;
  bool emailAutoValidate = false;
  bool passwordAutoValidate = false;

  @override
  void initState() {
    super.initState();
  }

  onSubmit() {
    if (registerFormKey.currentState.validate()) {
      final form = registerFormKey.currentState;
      form.save();

      setState(() => Global.isLoading = true);
      context
          .read<FirebaseAuthService>()
          .createWithEmailAndPassword(email: _email, password: _password)
          .then((user) async {
        user.raisonSociale = _raisonSociale;
        user.phone = _phone;
        await user.create();

        setState(() => Global.isLoading = false);
        context.read<AuthProvider>().updateUser(user: user);
        Navigator.of(context).pushNamed('map-street');
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     'dashboard', (Route<dynamic> route) => false);
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
      progressIndicator: AppLoader(),
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
                          margin: EdgeInsets.only(bottom: 8, top: 24),
                          width: double.infinity,
                          child: Text('Commençons',
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkColor)),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 24),
                          child: Text(
                              'Il ne reste plus que quelques pas à faire',
                              style: AppStyles.greyTextStyle),
                        ),
                        Form(
                          key: registerFormKey,
                          child: Column(
                            children: [
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  autovalidate: raisonAutoValidate,
                                  initialValue: '',
                                  onTap: () =>
                                      setState(() => raisonAutoValidate = true),
                                  decoration: hintTextDecoration(
                                      'Nom de l\'entreprise'),
                                  validator: (value) => Validators.required(
                                      value,
                                      errorText:
                                          'Veuillez saisir nom de l\'entreprise'),
                                  keyboardType: TextInputType.text,
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontSize: 18),
                                  onSaved: (val) =>
                                      setState(() => _raisonSociale = val),
                                ),
                              ),
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  autovalidate: phoneAutoValidate,
                                  initialValue: '',
                                  onTap: () =>
                                      setState(() => phoneAutoValidate = true),
                                  decoration:
                                      hintTextDecoration('Numéro de téléphone'),
                                  validator: (value) => Validators.mustNumeric(
                                      value,
                                      errorText:
                                          'Veuillez saisir un numéro de téléphone valide'),
                                  keyboardType: TextInputType.phone,
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontSize: 18),
                                  onSaved: (val) =>
                                      setState(() => _phone = val),
                                ),
                              ),
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  autovalidate: emailAutoValidate,
                                  initialValue: '',
                                  onTap: () =>
                                      setState(() => emailAutoValidate = true),
                                  decoration: hintTextDecoration('Email'),
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
                                  autovalidate: passwordAutoValidate,
                                  onTap: () => setState(
                                      () => passwordAutoValidate = true),
                                  decoration: hintTextDecoration('Mot de passe')
                                      .copyWith(
                                    suffixIcon: IconButton(
                                        icon: absure
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () =>
                                            setState(() => absure = !absure)),
                                  ),
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
                                  onChanged: (val) =>
                                      setState(() => _password = val),
                                ),
                              ),
                              FormFieldContainer(
                                padding: EdgeInsets.all(4),
                                child: TextFormField(
                                  autovalidate: passwordAutoValidate,
                                  onTap: () => setState(
                                      () => passwordAutoValidate = true),
                                  decoration: hintTextDecoration(
                                      'Répéter mot de passe'),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Veuillez saisir votre mot de passe';
                                    }
                                    if (val != _password) {
                                      return 'Le mot de passe ne correspond pas';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: absure,
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontSize: 18),
                                  onSaved: (val) =>
                                      setState(() => _confirmPassword = val),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 24, bottom: 98),
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
                                    child: Text('Créer un compte',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
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
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Vous avez déjà un compte? ',
                                        style: AppStyles.greyTextStyle),
                                    GestureDetector(
                                      child: Text(' Se connecter',
                                          style: AppStyles.primaryTextStyle),
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
