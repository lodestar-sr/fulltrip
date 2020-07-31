import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/index.dart';
import 'package:Fulltrip/widgets/form_field_container/index.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final changePasswordFormKey = GlobalKey<FormState>();
  String oldPassword = '';
  String newPassword = '';
  String retypePassword = '';
  FocusNode oldPasswordNode = FocusNode();
  FocusNode newPasswordNode = FocusNode();
  FocusNode retypePasswordNode = FocusNode();
  bool validateoldPassword = false;
  bool validatenewPassword = false;
  bool validateretypePassword = false;
  bool absureoldPassword = true;
  bool absurenewPassword = true;
  bool absureretypePassword = true;
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
              title: Text('Changer le mot de passe',
                  style: TextStyle(fontSize: 20, color: AppColors.darkColor)),
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
                              child: Form(
                                key: changePasswordFormKey,
                                child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(16, 30, 16, 40),
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
                                                'Ancien mot de passe',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: FormFieldContainer(
                                                  padding: EdgeInsets.all(4),
                                                  child: TextFormField(
                                                    initialValue: '',
                                                    onChanged: (value) {
                                                      setState(() {
                                                        validateoldPassword =
                                                            true;
                                                      });
                                                    },
                                                    autovalidate:
                                                        validateoldPassword,
                                                    focusNode: oldPasswordNode,
                                                    onFieldSubmitted: (value) {
                                                      newPasswordNode
                                                          .requestFocus();
                                                    },
                                                    decoration: hintTextDecoration(
                                                            "Entrez l'ancien mot de passe")
                                                        .copyWith(
                                                            suffixIcon: IconButton(
                                                                icon: absureoldPassword
                                                                    ? Icon(Icons
                                                                        .visibility_off)
                                                                    : Icon(Icons
                                                                        .visibility),
                                                                onPressed: () =>
                                                                    setState(() =>
                                                                        absureoldPassword =
                                                                            !absureoldPassword))),
                                                    obscureText:
                                                        absureoldPassword,
                                                    validator: (value) =>
                                                        Validators.required(
                                                            value,
                                                            errorText:
                                                                "Veuillez entrer l'ancien mot de passe"),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    style: AppStyles
                                                        .greyTextStyle
                                                        .copyWith(fontSize: 18),
                                                    onSaved: (val) => setState(
                                                        () =>
                                                            oldPassword = val),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  'Nouveau mot de passe',
                                                  style: AppStyles
                                                      .blackTextStyle
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                              FormFieldContainer(
                                                padding: EdgeInsets.all(4),
                                                child: TextFormField(
                                                  initialValue: '',
                                                  onChanged: (value) {
                                                    setState(() {
                                                      validatenewPassword =
                                                          true;
                                                      newPassword = value;
                                                    });
                                                  },
                                                  autovalidate:
                                                      validatenewPassword,
                                                  focusNode: newPasswordNode,
                                                  onFieldSubmitted: (value) {
                                                    retypePasswordNode
                                                        .requestFocus();
                                                  },
                                                  decoration: hintTextDecoration(
                                                          "Entrez un nouveau mot de passe")
                                                      .copyWith(
                                                          suffixIcon: IconButton(
                                                              icon: absurenewPassword
                                                                  ? Icon(Icons
                                                                      .visibility_off)
                                                                  : Icon(Icons
                                                                      .visibility),
                                                              onPressed: () =>
                                                                  setState(() =>
                                                                      absurenewPassword =
                                                                          !absurenewPassword))),
                                                  validator: (value) =>
                                                      Validators.required(value,
                                                          errorText:
                                                              "Veuillez entrer un nouveau mot de passe"),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  style: AppStyles.greyTextStyle
                                                      .copyWith(fontSize: 18),
                                                  onSaved: (val) => setState(
                                                      () => newPassword = val),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  'Retapez le nouveau mot de passe',
                                                  style: AppStyles
                                                      .blackTextStyle
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                              FormFieldContainer(
                                                padding: EdgeInsets.all(4),
                                                child: TextFormField(
                                                  initialValue: '',
                                                  decoration: hintTextDecoration(
                                                          "Retapez le nouveau mot de passe")
                                                      .copyWith(
                                                          suffixIcon: IconButton(
                                                              icon: absureretypePassword
                                                                  ? Icon(Icons
                                                                      .visibility_off)
                                                                  : Icon(Icons
                                                                      .visibility),
                                                              onPressed: () =>
                                                                  setState(() =>
                                                                      absureretypePassword =
                                                                          !absureretypePassword))),
                                                  validator: (value) {
                                                    if (value.trim().isEmpty) {
                                                      return "Veuillez retaper le nouveau mot de passe";
                                                    } else if (newPassword !=
                                                        value) {
                                                      return "Les mots de passe ne correspondent pas";
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.text,
                                                  style: AppStyles.greyTextStyle
                                                      .copyWith(fontSize: 18),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      validateretypePassword =
                                                          true;
                                                    });
                                                  },
                                                  autovalidate:
                                                      validateretypePassword,
                                                  focusNode: retypePasswordNode,
                                                  onSaved: (val) => setState(
                                                      () =>
                                                          retypePassword = val),
                                                ),
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
                                                  changePasswordFormKey
                                                      .currentState
                                                      .validate();
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                elevation: 0,
                                              ),
                                            ),
                                          ),
                                        ])),
                              )))));
            })));
  }
}
