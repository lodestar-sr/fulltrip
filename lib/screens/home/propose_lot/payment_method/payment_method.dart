import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/text_formatter.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({Key key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
//  String firstname = '';
  String iban = '';
  String bic = '';
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    iban = context.read<AuthProvider>().loggedInUser.iban;
    bic = context.read<AuthProvider>().loggedInUser.bic;
  }

  onSave() async {
    if (formKey.currentState.validate()) {
      final form = formKey.currentState;
      form.save();

      setState(() {
        context.read<AuthProvider>().loggedInUser.iban = iban;
        context.read<AuthProvider>().loggedInUser.bic = bic;
      });
      setState(() => Global.isLoading = true);
      await context.read<AuthProvider>().loggedInUser.save(context);
      setState(() => Global.isLoading = false);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Moyens de paiement mis à jour avec succès'),
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
//                                          RichText(
//                                            text: TextSpan(
//                                              text: 'Nom et prénom du titulaire',
//                                              style: TextStyle(fontSize: 15, color: AppColors.darkColor, fontWeight: FontWeight.w500),
//                                              children: <TextSpan>[
//                                                TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.redColor)),
//                                              ],
//                                            ),
//                                          ),
//                                          TextFormField(
//                                            initialValue: '',
//                                            decoration: hintTextDecoration('Entrer '),
//                                            validator: (value) => Validators.required(value, errorText: 'Veuillez saisir le nom et le prénom du titulaire'),
//                                            keyboardType: TextInputType.text,
//                                            style: AppStyles.greyTextStyle.copyWith(fontSize: 18),
//                                            onSaved: (val) => setState(() => firstname = val),
//                                          ),
                            Padding(
                              padding: EdgeInsets.only(top: 24),
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
                              initialValue: iban,
                              inputFormatters: [
                                MaskedTextInputFormatter(
                                  mask: 'xxxx-xxxx-xxxx-xxxx-xxx',
                                  separator: '-',
                                ),
                              ],
                              decoration: hintTextDecoration('1111-2222-2222-2222-333'),
                              validator: (value) => Validators.required(value, errorText: 'Veuillez entrer IBAN'),
                              keyboardType: TextInputType.text,
                              style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
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
                              initialValue: bic,
                              decoration: hintTextDecoration('EFR34XXX'),
                              validator: (value) => Validators.required(value, errorText: 'Veuillez entrer BIC'),
                              keyboardType: TextInputType.text,
                              style: AppStyles.blackTextStyle.copyWith(fontSize: 18),
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
            ),
          );
        }),
      ),
    );
  }
}
