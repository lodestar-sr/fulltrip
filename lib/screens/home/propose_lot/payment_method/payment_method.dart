import 'package:Fulltrip/util/TextFormatter.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({Key key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String firstname = '';
  String iban = '';
  String bic = '';
  final formKey = GlobalKey<FormState>();

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
              title: Text(
                'Moyens de paiement',
                style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
              ),
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
                                  padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
                                  child: Form(
                                    key: formKey,
                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Nom et prénom du titulaire',
                                              style: TextStyle(fontSize: 15, color: AppColors.darkColor, fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                                TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.redColor)),
                                              ],
                                            ),
                                          ),
                                          TextFormField(
                                            initialValue: '',
                                            decoration: hintTextDecoration('Entrer '),
                                            validator: (value) => Validators.required(value, errorText: 'Veuillez saisir le nom et le prénom du titulaire'),
                                            keyboardType: TextInputType.text,
                                            style: AppStyles.greyTextStyle.copyWith(fontSize: 18),
                                            onSaved: (val) => setState(() => firstname = val),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 25.0),
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'IBAN',
                                                style: TextStyle(fontSize: 15, color: AppColors.darkColor, fontWeight: FontWeight.w500),
                                                children: <TextSpan>[
                                                  TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.redColor)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          TextFormField(
                                            initialValue: '',
                                            inputFormatters: [
                                              MaskedTextInputFormatter(
                                                mask: 'xxxx-xxxx-xxxx-xxxx-xxx',
                                                separator: '-',
                                              ),
                                            ],
                                            decoration: hintTextDecoration('Entrer IBAN'),
                                            validator: (value) => Validators.required(value, errorText: 'Veuillez entrer IBAN'),
                                            keyboardType: TextInputType.phone,
                                            style: AppStyles.greyTextStyle.copyWith(fontSize: 18),
                                            onSaved: (val) => setState(() => iban = val),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 25.0),
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'BIC',
                                                style: TextStyle(fontSize: 15, color: AppColors.darkColor, fontWeight: FontWeight.w500),
                                                children: <TextSpan>[
                                                  TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.redColor)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          TextFormField(
                                            initialValue: '',
                                            decoration: hintTextDecoration('Entrer BIC'),
                                            validator: (value) => Validators.required(value, errorText: 'Veuillez entrer BIC'),
                                            keyboardType: TextInputType.text,
                                            style: AppStyles.greyTextStyle.copyWith(fontSize: 18),
                                            onSaved: (val) => setState(() => bic = val),
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
                                              formKey.currentState.validate();
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            elevation: 0,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ))))));
            })));
  }
}
