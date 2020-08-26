import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/index.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:Fulltrip/widgets/form_field_container.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Commanditaire extends StatefulWidget {
  Commanditaire({Key key}) : super(key: key);

  @override
  _CommanditaireState createState() => _CommanditaireState();
}

class _CommanditaireState extends State<Commanditaire> {
  final commanditaireFormKey = GlobalKey<FormState>();

  String lastName = '';
  String firstName = '';

  @override
  void initState() {
    super.initState();
    lastName = context.read<AuthProvider>().loggedInUser.lastName;
    firstName = context.read<AuthProvider>().loggedInUser.firstName;
  }

  onSave() async {
    if (commanditaireFormKey.currentState.validate()) {
      final form = commanditaireFormKey.currentState;
      form.save();

      setState(() {
        context.read<AuthProvider>().loggedInUser.lastName = lastName;
        context.read<AuthProvider>().loggedInUser.firstName = firstName;
      });
      setState(() => Global.isLoading = true);
      await context.read<AuthProvider>().loggedInUser.save(context);
      setState(() => Global.isLoading = false);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Commanditaire mis à jour avec succès'),
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
          backgroundColor: AppColors.lightestGreyColor,
          iconTheme: IconThemeData(
            color: AppColors.backButtonColor, //change your color here
          ),
          title: Text('Nom et prénom du commanditaire',
              style: AppStyles.blackTextStyle),
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Form(
            key: commanditaireFormKey,
            child: Container(
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
                                'Nom du commanditaire',
                                style: AppStyles.blackTextStyle
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              FormFieldContainer(
                                child: TextFormField(
                                  initialValue: lastName,
                                  decoration: hintTextDecoration(
                                      'Entrer Nom du commanditaire'),
                                  validator: (value) => Validators.required(
                                      value,
                                      errorText:
                                          'Veuillez Entrer Nom du commanditaire'),
                                  keyboardType: TextInputType.text,
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontSize: 16),
                                  onSaved: (val) =>
                                      setState(() => lastName = val),
                                ),
                              ),

                              //
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  'Prénom du commanditaire',
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                              FormFieldContainer(
                                child: TextFormField(
                                  initialValue: firstName,
                                  decoration: hintTextDecoration(
                                      'Entrer Prénom du commanditaire'),
                                  validator: (value) => Validators.required(
                                      value,
                                      errorText:
                                          'Veuillez Entrer Prénom du commanditaire'),
                                  keyboardType: TextInputType.text,
                                  style: AppStyles.blackTextStyle
                                      .copyWith(fontSize: 16),
                                  onSaved: (val) =>
                                      setState(() => firstName = val),
                                ),
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
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
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
