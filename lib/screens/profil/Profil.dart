import 'package:flutter/material.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/size_config.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Profil extends StatefulWidget {
  Profil({Key key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
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
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 40),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  Global.profileoptions.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 0.0),
                                                  leading: Image.asset(
                                                    'assets/images/$index.png',
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  title: Text(
                                                    Global
                                                        .profileoptions[index],
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.darkColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  onTap: () {
                                                    print(index);
                                                    index == 0
                                                        ? Navigator.of(context)
                                                            .pushNamed(
                                                                'mes_informations')
                                                        : null;
                                                    index == 1
                                                        ? Navigator.of(context)
                                                            .pushNamed(
                                                                'CoordonneesBancaries')
                                                        : null;
                                                    index == 2 ? null : null;
                                                    index == 3 ? null : null;
                                                    index == 4 ? null : null;
                                                    index == 5 ? null : null;
                                                  },
                                                );
                                              }),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  SizeConfig.safeBlockVertical *
                                                      20),
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 0.0),
                                            leading: Icon(
                                              Icons.error_outline,
                                              color: AppColors.primaryColor,
                                              size: 30,
                                            ),
                                            title: Text(
                                              "Centre d'aide",
                                              style: TextStyle(
                                                  color: AppColors.darkColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      ]))))));
            })));
  }
}
