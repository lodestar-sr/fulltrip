import 'package:flutter/material.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/size_config.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MesDocuments extends StatefulWidget {
  MesDocuments({Key key}) : super(key: key);

  @override
  _MesDocumentsState createState() => _MesDocumentsState();
}

class _MesDocumentsState extends State<MesDocuments> {
  bool insurance = false;
  bool transportLicenses = false;
  bool kbisdocument = false;
  bool identityCard = false;
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
              title: Text('Mes documents'),
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
                                  padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                    "Attestation d'assurance en cours de validité sur 2020",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.darkColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: ' *',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .redColor)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip... ''',
                                                style: AppStyles
                                                    .navbarInactiveTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .greyColor),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Visibility(
                                                visible: insurance,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Fichier sélectionné',
                                                      style: AppStyles
                                                          .navbarInactiveTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mediumGreyColor),
                                                    ),
                                                    Text(
                                                      'Supprimer un fichier',
                                                      style: AppStyles
                                                          .navbarInactiveTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .redColor),
                                                    )
                                                  ],
                                                ),
                                                replacement: Text(
                                                  'Ajouter un fichier',
                                                  style: AppStyles
                                                      .navbarInactiveTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor),
                                                ),
                                              ),
                                            ),
                                            Divider(),

                                            ///
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                    "Copie des licences de transport",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.darkColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: ' *',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .redColor)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip... ''',
                                                style: AppStyles
                                                    .navbarInactiveTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .greyColor),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Visibility(
                                                visible: transportLicenses,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Fichier sélectionné',
                                                      style: AppStyles
                                                          .navbarInactiveTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mediumGreyColor),
                                                    ),
                                                    Text(
                                                      'Supprimer un fichier',
                                                      style: AppStyles
                                                          .navbarInactiveTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .redColor),
                                                    )
                                                  ],
                                                ),
                                                replacement: Text(
                                                  'Ajouter un fichier',
                                                  style: AppStyles
                                                      .navbarInactiveTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor),
                                                ),
                                              ),
                                            ),
                                            Divider(),
                                            ////
                                            RichText(
                                              text: TextSpan(
                                                text: "Extrait Kbis",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.darkColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: ' *',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .redColor)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip... ''',
                                                style: AppStyles
                                                    .navbarInactiveTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .greyColor),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Visibility(
                                                visible: kbisdocument,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Fichier sélectionné',
                                                      style: AppStyles
                                                          .navbarInactiveTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mediumGreyColor),
                                                    ),
                                                    Text(
                                                      'Supprimer un fichier',
                                                      style: AppStyles
                                                          .navbarInactiveTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .redColor),
                                                    )
                                                  ],
                                                ),
                                                replacement: Text(
                                                  'Ajouter un fichier',
                                                  style: AppStyles
                                                      .navbarInactiveTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor),
                                                ),
                                              ),
                                            ),
                                            Divider(),
                                            ////
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                    "Carte nationale d'identité du gérant",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.darkColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: ' *',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .redColor)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip... ''',
                                                style: AppStyles
                                                    .navbarInactiveTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .greyColor),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: Visibility(
                                                visible: identityCard,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Fichier sélectionné',
                                                      style: AppStyles
                                                          .navbarInactiveTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mediumGreyColor),
                                                    ),
                                                    Text(
                                                      'Supprimer un fichier',
                                                      style: AppStyles
                                                          .navbarInactiveTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .redColor),
                                                    )
                                                  ],
                                                ),
                                                replacement: Text(
                                                  'Ajouter un fichier',
                                                  style: AppStyles
                                                      .navbarInactiveTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor),
                                                ),
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
                                                setState(() {
                                                  insurance = true;
                                                  transportLicenses = true;
                                                  kbisdocument = true;
                                                  identityCard = true;
                                                });
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
