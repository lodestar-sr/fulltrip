import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
              iconTheme: IconThemeData(
                color: AppColors.backButtonColor, //change your color here
              ),
              title: Text('Coordonnées bancaires',
                  style: AppStyles.blackTextStyle),
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
                                                children: <TextSpan>[],
                                              ),
                                            ),

                                            ListTile(
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              leading: Icon(
                                                Feather.file_text,
                                                color: AppColors.primaryColor,
                                              ),
                                              title: Align(
                                                alignment: Alignment(-1.25, 0),
                                                child: Text(
                                                  'Ajouter un fichier',
                                                  style: AppStyles
                                                      .navbarActiveTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ),

                                            ListTile(
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              leading: Icon(
                                                Feather.image,
                                                color: AppColors.primaryColor,
                                              ),
                                              title: Align(
                                                alignment: Alignment(-1.25, 0),
                                                child: Text(
                                                  'Ajouter une photo',
                                                  style: AppStyles
                                                      .navbarActiveTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    dense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.0),
                                                    leading: Icon(
                                                      Feather.edit_3,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    title: Align(
                                                      alignment:
                                                          Alignment(-1.25, 0),
                                                      child: Text(
                                                        'Modifier',
                                                        style: AppStyles
                                                            .navbarActiveTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: AppColors.redColor,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Supprimer',
                                                      style: AppStyles
                                                          .navbarActiveTextStyle
                                                          .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .redColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                                children: <TextSpan>[],
                                              ),
                                            ),
                                            ListTile(
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              leading: Icon(
                                                Feather.file_text,
                                                color: AppColors.primaryColor,
                                              ),
                                              title: Align(
                                                alignment: Alignment(-1.25, 0),
                                                child: Text(
                                                  'Ajouter un fichier',
                                                  style: AppStyles
                                                      .navbarActiveTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ),

                                            ListTile(
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              leading: Icon(
                                                Feather.image,
                                                color: AppColors.primaryColor,
                                              ),
                                              title: Align(
                                                alignment: Alignment(-1.25, 0),
                                                child: Text(
                                                  'Ajouter une photo',
                                                  style: AppStyles
                                                      .navbarActiveTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    dense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.0),
                                                    leading: Icon(
                                                      Feather.edit_3,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    title: Align(
                                                      alignment:
                                                          Alignment(-1.25, 0),
                                                      child: Text(
                                                        'Modifier',
                                                        style: AppStyles
                                                            .navbarActiveTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: AppColors.redColor,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Supprimer',
                                                      style: AppStyles
                                                          .navbarActiveTextStyle
                                                          .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .redColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                                children: <TextSpan>[],
                                              ),
                                            ),

                                            ListTile(
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              leading: Icon(
                                                Feather.file_text,
                                                color: AppColors.primaryColor,
                                              ),
                                              title: Align(
                                                alignment: Alignment(-1.25, 0),
                                                child: Text(
                                                  'Ajouter un fichier',
                                                  style: AppStyles
                                                      .navbarActiveTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ),

                                            ListTile(
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              leading: Icon(
                                                Feather.image,
                                                color: AppColors.primaryColor,
                                              ),
                                              title: Align(
                                                alignment: Alignment(-1.25, 0),
                                                child: Text(
                                                  'Ajouter une photo',
                                                  style: AppStyles
                                                      .navbarActiveTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    dense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.0),
                                                    leading: Icon(
                                                      Feather.edit_3,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    title: Align(
                                                      alignment:
                                                          Alignment(-1.25, 0),
                                                      child: Text(
                                                        'Modifier',
                                                        style: AppStyles
                                                            .navbarActiveTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: AppColors.redColor,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Supprimer',
                                                      style: AppStyles
                                                          .navbarActiveTextStyle
                                                          .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .redColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                                children: <TextSpan>[],
                                              ),
                                            ),

                                            ListTile(
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              leading: Icon(
                                                Feather.file_text,
                                                color: AppColors.primaryColor,
                                              ),
                                              title: Align(
                                                alignment: Alignment(-1.25, 0),
                                                child: Text(
                                                  'Ajouter un fichier',
                                                  style: AppStyles
                                                      .navbarActiveTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ),

                                            ListTile(
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              leading: Icon(
                                                Feather.image,
                                                color: AppColors.primaryColor,
                                              ),
                                              title: Align(
                                                alignment: Alignment(-1.25, 0),
                                                child: Text(
                                                  'Ajouter une photo',
                                                  style: AppStyles
                                                      .navbarActiveTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    dense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.0),
                                                    leading: Icon(
                                                      Feather.edit_3,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    title: Align(
                                                      alignment:
                                                          Alignment(-1.25, 0),
                                                      child: Text(
                                                        'Modifier',
                                                        style: AppStyles
                                                            .navbarActiveTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: AppColors.redColor,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Supprimer',
                                                      style: AppStyles
                                                          .navbarActiveTextStyle
                                                          .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .redColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Container(
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
                                                      BorderRadius.circular(10),
                                                ),
                                                elevation: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]))))));
            })));
  }
}
