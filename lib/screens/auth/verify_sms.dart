import 'dart:collection';

import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class VerifySMS extends StatefulWidget {
  VerifySMS({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifySMSState();
}

class _VerifySMSState extends State<VerifySMS> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  User user;
  String verificationCode;
  int countTime = 120;

  @override
  void initState() {
    updateTime();
  }

  updateTime() {
    setState(() {
      if (countTime > 0) {
        countTime--;
      } else {
        verificationCode = null;
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      updateTime();
    });
  }

  initUser() {
    final LinkedHashMap<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (args == null) {
      Navigator.of(context).pop();
    } else {
      setState(() => user = args['user']);
      sendCode();
    }
  }

  sendCode() {
    setState(() {
      countTime = 120;
      _pinPutController.text = '';
    });
    context.select((FirebaseAuthService fas) {
      fas.verifyPhone(
        number: '+' + user.phone,
        onCodeSent: (code) {
          setState(() {
            verificationCode = code;
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('We sent verification SMS code to your phone. Please input code'),
              );
            },
          );
        },
        onCompleted: (authCred) {},
        onFailed: (err) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(err),
              );
            },
          );
        },
      );
    });
  }

  onSubmit() {
    if (verificationCode != null && _pinPutController.text.isNotEmpty) {
      final AuthCredential authCred = PhoneAuthProvider.getCredential(verificationId: verificationCode, smsCode: _pinPutController.text);
      Global.auth.signInWithCredential(authCred).then((value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Numéro de téléphone vérifié avec succès'),
            );
          },
        );
        Navigator.of(context).pop();
      }).catchError((error) {
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
    if (user == null) {
      initUser();
    }

    BoxDecoration pinPutDecoration = BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.lightGreyColor));
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
                  child: IntrinsicHeight(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 32, 16, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8, top: 16),
                            width: double.infinity,
                            child: Text('Vérification code', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppColors.darkColor)),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 64),
                            width: double.infinity,
                            child: Text('Vérifiez votre compte en entrant le code à 6 chiffres envoyé à: + ${user != null ? user.phone : ''}', style: AppStyles.greyTextStyle),
                          ),
                          Container(
                            child: PinPut(
                              eachFieldWidth: 40,
                              eachFieldHeight: 40,
                              fieldsCount: 6,
                              focusNode: _pinPutFocusNode,
                              controller: _pinPutController,
                              submittedFieldDecoration: pinPutDecoration,
                              selectedFieldDecoration: pinPutDecoration,
                              followingFieldDecoration: pinPutDecoration,
                              pinAnimationType: PinAnimationType.fade,
                              textStyle: TextStyle(color: AppColors.darkColor, fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: countTime > 0
                                  ? Text('Renvoyer le code en ${(countTime / 60).floor()}:${countTime % 60}', style: AppStyles.greyTextStyle.copyWith(fontSize: 12))
                                  : GestureDetector(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Renvoyer',
                                          style: AppStyles.primaryTextStyle.copyWith(fontSize: 12),
                                          children: <TextSpan>[
                                            TextSpan(text: ' le code du téléphone', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      onTap: sendCode,
                                    ),
                            ),
                          ),
                          Container(
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
                                child: Text('Vérifier', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
