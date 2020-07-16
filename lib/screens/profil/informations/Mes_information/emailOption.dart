import 'package:flutter/material.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/size_config.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/util/validators/validators.dart';
import 'package:fulltrip/widgets/form_field_container/index.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EmailOption extends StatefulWidget {
  EmailOption({Key key}) : super(key: key);

  @override
  _EmailOptionState createState() => _EmailOptionState();
}

class _EmailOptionState extends State<EmailOption> {
  String _email = '';
  final emailFormKey = GlobalKey<FormState>();
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
              title: Text('Email'),
            ),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: GestureDetector(
                          onTap: () => FocusScope.of(context)
                              .requestFocus(new FocusNode()),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(16, 30, 16, 40),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Change Email',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            Form(
                                              key: emailFormKey,
                                              child: FormFieldContainer(
                                                padding: EdgeInsets.all(4),
                                                child: TextFormField(
                                                  initialValue: '',
                                                  decoration: hintTextDecoration(
                                                          'Enter')
                                                      .copyWith(
                                                          prefixIcon: Icon(Icons
                                                              .mail_outline)),
                                                  validator: (value) =>
                                                      Validators.mustEmail(
                                                          value,
                                                          errorText:
                                                              'Veuillez saisir votre email valide'),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  style: AppStyles.greyTextStyle
                                                      .copyWith(fontSize: 18),
                                                  onSaved: (val) => setState(
                                                      () => _email = val),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.0),
                                              child: Text(
                                                  'We Will Send verification to your New Email',
                                                  style: AppStyles
                                                      .primaryTextStyle
                                                      .copyWith(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: AppColors.whiteColor
                                                      .withOpacity(0.3),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              color: AppColors.primaryColor,
                                              textColor: Color(0xFF343434),
                                              onPressed: () {
                                                emailFormKey.currentState
                                                    .validate();
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              elevation: 0,
                                            ),
                                          ),
                                        ),
                                      ]))))));
            })));
  }
}
