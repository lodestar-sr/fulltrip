import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:Fulltrip/widgets/form_field_container.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ChangeEmail extends StatefulWidget {
  ChangeEmail({Key key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final emailFormKey = GlobalKey<FormState>();

  String email = '';

  @override
  void initState() {
    super.initState();
    email = context.read<AuthProvider>().loggedInUser.email;
  }

  onSave() async {
    if (emailFormKey.currentState.validate()) {
      final form = emailFormKey.currentState;
      form.save();

      setState(() {
        context.read<AuthProvider>().loggedInUser.email = email;
      });
      setState(() => Global.isLoading = true);
      await context.read<FirebaseAuthService>().updateEmail(email);
      await context.read<AuthProvider>().loggedInUser.save(context);
      setState(() => Global.isLoading = false);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('E-mail mis à jour avec succès'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: AppColors.backButtonColor, //change your color here
          ),
          title: Text('Email', style: AppStyles.blackTextStyle),
        ),
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
                    padding: EdgeInsets.fromLTRB(16, 30, 16, 40),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Changer d'email",
                                style: AppStyles.blackTextStyle
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Form(
                                key: emailFormKey,
                                child: FormFieldContainer(
                                  padding: EdgeInsets.all(4),
                                  child: TextFormField(
                                    initialValue: email,
                                    decoration: hintTextDecoration(
                                        'Entrez votre e-mail'),
                                    validator: (value) => Validators.mustEmail(
                                        value,
                                        errorText:
                                            'Veuillez saisir votre email valide'),
                                    keyboardType: TextInputType.emailAddress,
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontSize: 16),
                                    onSaved: (val) =>
                                        setState(() => email = val),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'Un email de vérification vous sera envoyé',
                                    style: AppStyles.primaryTextStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xFF40BFFF))),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color:
                                        AppColors.whiteColor.withOpacity(0.3),
                                    blurRadius: 16,
                                    spreadRadius: 4),
                              ],
                            ),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              height: 60,
                              child: RaisedButton(
                                child: Text('Sauvegarder',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                color: AppColors.primaryColor,
                                textColor: Color(0xFF343434),
                                onPressed: onSave,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ]),
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
