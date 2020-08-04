import 'package:Fulltrip/services/auth.service.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Compte extends StatefulWidget {
  Compte({Key key}) : super(key: key);

  @override
  _CompteState createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  AuthService _authService;

  @override
  void initState() {
    _authService = AuthService.getInstance();
    Global.isLoading = false;
  }

  signOut() {
    context.read<FirebaseAuthService>().signOut().then((value) async {
      await _authService.updateUser(user: null);
      Navigator.of(context).pushReplacementNamed('login');
    });
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
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: AppColors.backButtonColor, //change your color here
              ),
              title: Text('Compte', style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500)),
              centerTitle: true,
            ),
            body: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                    child: GestureDetector(
                        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 40),
                            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                              Container(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: Global.profileOptions.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                            leading: Icon(Global.profileIcons[index], size: 26, color: AppColors.primaryColor),
                                            title: Text(
                                              Global.profileOptions[index],
                                              style: TextStyle(color: AppColors.darkColor, fontWeight: FontWeight.w500),
                                            ),
                                            onTap: () {
                                              index == 0 ? Navigator.of(context).pushNamed('mes_informations') : null;
                                              index == 1 ? Navigator.of(context).pushNamed('Announces') : null;
                                              index == 2 ? Navigator.of(context).pushNamed('TransPort') : null;
                                              index == 3 ? Navigator.of(context).pushNamed('centredaide') : null;
                                              index == 4 ? null : null;
                                              index == 5 ? Navigator.of(context).pushNamed('mesdocuments') : null;
                                              index == 6 ? Navigator.of(context).pushNamed('mesdocuments') : null;
                                              index == 7 ? null : null;
                                            },
                                          ),
                                          Container(
                                            color: AppColors.compteDivider,
                                            height: 1,
                                          )
                                        ],
                                      );
                                    }),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 12),
                                child: Column(
                                  children: [
                                    Container(
                                      color: AppColors.compteDivider,
                                      height: 1,
                                    ),
                                    ListTile(
                                      onTap: () => signOut(),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                      leading: Icon(
                                        Feather.log_out,
                                        color: AppColors.redColor,
                                        size: 30,
                                      ),
                                      title: Text(
                                        'Se déconnecter',
                                      ),
                                    ),
                                    Container(
                                      color: AppColors.compteDivider,
                                      height: 1,
                                    )
                                  ],
                                ),
                              )
                            ])))))));
  }
}
