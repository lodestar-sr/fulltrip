import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TransactionInformation extends StatefulWidget {
  TransactionInformation({Key key}) : super(key: key);

  @override
  _TransactionInformationState createState() => _TransactionInformationState();
}

class _TransactionInformationState extends State<TransactionInformation> {
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
              title: Text(
                'Informations sur les transactions',
                style: AppStyles.blackTextStyle
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
              ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Point de départ',
                                                style: AppStyles
                                                    .navbarInactiveTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mediumGreyColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  'Paris',
                                                  style: AppStyles
                                                      .blackTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Text(
                                          'Adresse de départ',
                                          style: AppStyles
                                              .navbarInactiveTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.mediumGreyColor,
                                                  fontSize: 13),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text('40 Avenue Leon Blum',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Text(
                                            "Nom de l'entreprise",
                                            style: AppStyles
                                                .navbarInactiveTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .mediumGreyColor,
                                                    fontSize: 13),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text('40 Avenue Leon Blum',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Text(
                                            "Téléphone",
                                            style: AppStyles
                                                .navbarInactiveTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .mediumGreyColor,
                                                    fontSize: 13),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text('06 33 01 22 54',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ),
                                        Divider(),
                                        Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Point d'arrivée",
                                                style: AppStyles
                                                    .navbarInactiveTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mediumGreyColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  'Nice',
                                                  style: AppStyles
                                                      .blackTextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Text(
                                            "Adresse (où le colis est livré)",
                                            style: AppStyles
                                                .navbarInactiveTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .mediumGreyColor,
                                                    fontSize: 13),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text("2-6 Rue Joseph d'Arbaud",
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ),
                                        Divider(),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              'INFORMATIONS SUR LA LIVRAISON',
                                              style: AppStyles.primaryTextStyle
                                                  .copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Type d'accès",
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              Text(
                                                'Ascenseur',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Monte-meubles nécessaire ?",
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              Text(
                                                'Oui',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Quantité",
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              Text(
                                                '50m3',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Prestation",
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              Text(
                                                'Luxe',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Description",
                                            style: AppStyles
                                                .navbarInactiveTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .mediumGreyColor,
                                                    fontSize: 13),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                              "conditions de chargement, objets spéciaux, piano, coffre-fort",
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              'PAIEMENT',
                                              style: AppStyles.primaryTextStyle
                                                  .copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Le coût du voyage........................................",
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              Text(
                                                '500€',
                                                style: AppStyles.blackTextStyle
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]))))));
            })));
  }
}
