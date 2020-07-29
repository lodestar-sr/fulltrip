import 'package:Fulltrip/services/auth.service.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Profil extends StatefulWidget {
  Profil({Key key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {

  AuthService _authService;

  @override
  void initState() {
    _authService = AuthService.getInstance();
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
              title: Text('Profil'),
              centerTitle: true,
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
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 40),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                    Container(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: Global.profileOptions.length,
                                          itemBuilder: (BuildContext context, index) {
                                            return ListTile(
                                              contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                              leading: Icon(Global.profileIcons[index], size: 26, color: AppColors.primaryColor),
                                              title: Text(
                                                Global.profileOptions[index],
                                                style: TextStyle(color: AppColors.darkColor, fontWeight: FontWeight.w500),
                                              ),
                                              onTap: () {
                                                index == 0 ? Navigator.of(context).pushNamed('mes_informations') : null;
                                                index == 1 ? Navigator.of(context).pushNamed('CoordonneesBancaries') : null;
                                                index == 2 ? Navigator.of(context).pushNamed('transactionencours') : null;
                                                index == 3 ? Navigator.of(context).pushNamed('historiqueinformation') : null;
                                                index == 4 ? null : null;
                                                index == 5 ? Navigator.of(context).pushNamed('mesdocuments') : null;
                                                index == 6 ? Navigator.of(context).pushNamed('mesdocuments') : null;
                                                index == 7 ? signOut() : null;
                                              },
                                            );
                                          }),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
                                      child: ListTile(
                                        onTap: () => Navigator.of(context).pushNamed('centredaide'),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                        leading: Icon(
                                          Icons.error_outline,
                                          color: AppColors.primaryColor,
                                          size: 30,
                                        ),
                                        title: Text(
                                          "Centre d'aide",
                                        ),
                                      ),
                                    )
                                  ]))))));
            })));
  }
}
