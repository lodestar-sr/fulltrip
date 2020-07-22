import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CentreDaide extends StatefulWidget {
  CentreDaide({Key key}) : super(key: key);

  @override
  _CentreDaideState createState() => _CentreDaideState();
}

class _CentreDaideState extends State<CentreDaide> {
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
              title: Text(
                "Centre d'aide",
                style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 17),
              ),
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
                                  padding: EdgeInsets.fromLTRB(16, 16, 16, 40),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                      leading: Icon(
                                        Icons.help_outline,
                                        color: AppColors.mediumGreyColor,
                                        size: 25,
                                      ),
                                      title: Text(
                                        "Comment ça fonctionne ?",
                                        style: AppStyles.navbarActiveTextStyle.copyWith(color: AppColors.mediumGreyColor, fontSize: 14, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                      leading: Icon(
                                        Icons.help_outline,
                                        color: AppColors.mediumGreyColor,
                                        size: 25,
                                      ),
                                      title: Text(
                                        "Questions et réponses",
                                        style: AppStyles.navbarActiveTextStyle.copyWith(color: AppColors.mediumGreyColor, fontSize: 14, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                      leading: Icon(
                                        Icons.help_outline,
                                        color: Colors.transparent,
                                        size: 25,
                                      ),
                                      title: Text(
                                        "Nous contacter",
                                        style: AppStyles.navbarActiveTextStyle.copyWith(color: AppColors.mediumGreyColor, fontSize: 14, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ]))))));
            })));
  }
}
