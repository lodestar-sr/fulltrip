import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/services/firebase_auth.service.dart';
import 'package:Fulltrip/util/constants.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String checkStatus = 'incomplet';
  var trails = [
    Container(height: 14, width: 14),
    Container(height: 14, width: 14),
    Container(height: 14, width: 14),
    Container(height: 14, width: 14),
    Container(height: 14, width: 14),
    Container(height: 14, width: 14),
    Container(height: 14, width: 14),
    Container(height: 14, width: 14),
  ];

  //incomplete
  //verified

  @override
  void initState() {
    Global.isLoading = false;
    Global.customSearch.clear();
  }

  signOut() {
    context.read<FirebaseAuthService>().signOut().then((value) async {
      await context.read<AuthProvider>().updateUser(user: null);
      Navigator.of(context).pushReplacementNamed('login');
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (context.select((AuthProvider value) => value).getProfileBadgeCounter() == 0) {
      setState(() => checkStatus = 'validation');
      if (context
        .select((AuthProvider value) => value)
        .loggedInUser
        .isActivated) {
        setState(() => checkStatus = 'verified');
      }
    }

    if (context.watch<AuthProvider>().getInfoBadge() > 0) {
      trails[0] = Container(
        height: 14,
        width: 14,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        child: Center(
          child: Text(
            '${context.watch<AuthProvider>().getInfoBadge()}',
            style: TextStyle(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      trails[0] = Container(height: 14, width: 14);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: AppColors.backButtonColor, //change your color here
        ),
        title: Text('Compte', style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500)),
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration:
                    BoxDecoration(shape: BoxShape.circle, color: checkStatus == 'verified' ? AppColors.darkGreenColor : checkStatus == 'validation' ? AppColors.orangeColor : AppColors.redColor),
                    child: Text(
                      'd',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    checkStatus == 'verified' ? 'Vérifié' : checkStatus == 'validation' ? 'Validation en cours' : 'Incomplet',
                    style: AppStyles.blackTextStyle
                      .copyWith(fontSize: 14, color: checkStatus == 'verified' ? AppColors.darkGreenColor : checkStatus == 'validation' ? AppColors.orangeColor : AppColors.redColor),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: null),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Global.profileOptions.length,
                      separatorBuilder: (context, index) =>
                        Divider(
                          color: AppColors.profileDivider,
                        ),
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
                              trailing: trails[index],
                            ),
                            // Container(
                            //   color: AppColors.profileDivider,
                            //   height: 1,
                            // )
                          ],
                        );
                      }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 12),
                    child: Column(
                      children: [
                        Container(
                          color: AppColors.profileDivider,
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
                          color: AppColors.profileDivider,
                          height: 1,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'v${Constants.appVersion}',
                      style: AppStyles.versionTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
