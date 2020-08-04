import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/index.dart';
import 'package:Fulltrip/widgets/form_field_container/index.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RaisonSociale extends StatefulWidget {
  RaisonSociale({Key key}) : super(key: key);

  @override
  _RaisonSocialeState createState() => _RaisonSocialeState();
}

class _RaisonSocialeState extends State<RaisonSociale> {
  final raisonSocialeFormKey = GlobalKey<FormState>();
  String raisonSociale = '';

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
              title: Text('Raison sociale', style: AppStyles.blackTextStyle),
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
                                          'Raison sociale',
                                          style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                                        ),
                                        Form(
                                          key: raisonSocialeFormKey,
                                          child: FormFieldContainer(
                                            child: TextFormField(
                                              initialValue: '',
                                              decoration: hintTextDecoration('Entrer raison sociale'),
                                              validator: (value) => Validators.required(value, errorText: 'Veuillez saisir une raison sociale'),
                                              keyboardType: TextInputType.text,
                                              style: AppStyles.greyTextStyle.copyWith(fontSize: 18),
                                              onSaved: (val) => setState(() => raisonSociale = val),
                                            ),
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
                                          onPressed: () {
                                            raisonSocialeFormKey.currentState.validate();
                                          },
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
