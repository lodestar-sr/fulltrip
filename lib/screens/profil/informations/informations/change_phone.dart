import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ChangePhone extends StatefulWidget {
  ChangePhone({Key key}) : super(key: key);

  @override
  _ChangePhoneState createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {
  final phoneFormKey = GlobalKey<FormState>();

  String _phoneno = '';

  @override
  void initState() {
    super.initState();
    _phoneno = context.read<AuthProvider>().loggedInUser.phone;
  }

  onSave() async {
    if (phoneFormKey.currentState.validate()) {
      final form = phoneFormKey.currentState;
      form.save();

      setState(() {
        context.read<AuthProvider>().loggedInUser.phone = _phoneno;
      });
      setState(() => Global.isLoading = true);
      await context.read<AuthProvider>().loggedInUser.save(context);
      setState(() => Global.isLoading = false);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Le numéro de téléphone a été mis à jour avec succès'),
          );
        },
      );

//      User user  = context.read<AuthProvider>().loggedInUser;
//      user.phone = _phoneno;
//      Navigator.of(context).pushNamed('verify-sms', arguments: <String, User>{'user': user});
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.primaryColor,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: AppColors.backButtonColor, //change your color here
              ),
              title: Text('Téléphone', style: AppStyles.blackTextStyle),
            ),
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
                                  padding: EdgeInsets.fromLTRB(16, 30, 16, 40),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Changer le numéro',
                                          style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                                        ),
                                        Form(
                                          key: phoneFormKey,
                                          child: TextFormField(
                                            initialValue: _phoneno,
                                            decoration: hintTextDecoration('Entrez le numéro de téléphone'),
                                            validator: (value) => Validators.mustNumeric(value, errorText: 'Veuillez entrer votre numéro de téléphone valide'),
                                            keyboardType: TextInputType.phone,
                                            style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
                                            onSaved: (val) => setState(() => _phoneno = val),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(color: AppColors.whiteColor.withOpacity(0.3), blurRadius: 16, spreadRadius: 4),
                                        ],
                                      ),
                                      child: ButtonTheme(
                                        minWidth: double.infinity,
                                        height: 60,
                                        child: RaisedButton(
                                          child: Text('Sauvegarder', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
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
                                  ]))))));
            })));
  }
}
