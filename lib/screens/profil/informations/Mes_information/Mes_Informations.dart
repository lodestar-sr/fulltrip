import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Mes_Informations extends StatefulWidget {
  Mes_Informations({Key key}) : super(key: key);

  @override
  _Mes_InformationsState createState() => _Mes_InformationsState();
}

class _Mes_InformationsState extends State<Mes_Informations> {
  String email = '@yahoo.com';
  String phoneno = '(000) 000-0103';

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
              title: Text('Mes informations '),
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
                                  padding: EdgeInsets.fromLTRB(16, 30, 16, 40),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).pushNamed('emailoption'),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.email,
                                                color: AppColors.primaryColor,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                'Email',
                                                style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                email,
                                                style: AppStyles.greyTextStyle.copyWith(fontWeight: FontWeight.w400, color: AppColors.mediumGreyColor),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.mediumGreyColor,
                                                size: 20,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).pushNamed('telephoneoption'),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone_iphone,
                                                  color: AppColors.primaryColor,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  'Phone Number',
                                                  style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  phoneno,
                                                  style: AppStyles.greyTextStyle.copyWith(fontWeight: FontWeight.w400, color: AppColors.mediumGreyColor),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: AppColors.mediumGreyColor,
                                                  size: 20,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).pushNamed('adressedusiege'),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: AppColors.primaryColor,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  'Adresse du siège',
                                                  style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColors.mediumGreyColor,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).pushNamed('raisonsociale'),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.people_outline,
                                                  color: AppColors.primaryColor,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  'Raison sociale',
                                                  style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColors.mediumGreyColor,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_outline,
                                                color: AppColors.primaryColor,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                'Commanditaire',
                                                style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColors.mediumGreyColor,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).pushNamed('changepassword'),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.lock_outline,
                                                  color: AppColors.primaryColor,
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  'Changer le mot de passe',
                                                  style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '******',
                                                  style: AppStyles.greyTextStyle.copyWith(fontWeight: FontWeight.w400, color: AppColors.mediumGreyColor),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: AppColors.mediumGreyColor,
                                                  size: 20,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]))))));
            })));
  }
}
