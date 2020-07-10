import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerifySMS extends StatefulWidget {
  VerifySMS({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifySMSState();
}

class _VerifySMSState extends State<VerifySMS> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  String _email;
  String _password;

  onSubmit() {
    Navigator.of(context).pushNamed('dashboard');
  }

  @override
  Widget build(BuildContext context) {
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
                      padding: EdgeInsets.fromLTRB(16, 60, 16, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            width: double.infinity,
                            child: Text('Vérification code', style: TextStyle(fontSize: 28, color: AppColors.darkColor)),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 54),
                            width: double.infinity,
                            child: Text('Vérifiez votre compte en entrant le code à 4 chiffres envoyé à: + 380 000 00 00', style: AppStyles.greyTextStyle),
                          ),
                          Container(
                            child: PinPut(
                              eachFieldWidth: 60,
                              eachFieldHeight: 60,
                              fieldsCount: 4,
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
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Container(
                                  margin: EdgeInsets.only(top: 98, bottom: 32),
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
                                      child: Text('Appliquer les filtres', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text('Renvoyer le code en 00:12 ', style: AppStyles.greyTextStyle.copyWith(fontSize: 12)),
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
            ),
          );
        }),
      ),
    );
  }
}
