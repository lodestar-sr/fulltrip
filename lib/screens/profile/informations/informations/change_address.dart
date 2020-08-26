import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/util/validators/validators.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:Fulltrip/widgets/form_field_container.dart';
import 'package:Fulltrip/widgets/google_place_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ChangeAddress extends StatefulWidget {
  ChangeAddress({Key key}) : super(key: key);

  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  final headQFormKey = GlobalKey<FormState>();
  String headQAdd = '';

  @override
  void initState() {
    super.initState();
  }

  onSave() async {
    if (headQFormKey.currentState.validate()) {
      final form = headQFormKey.currentState;
      form.save();

      setState(() {
        context.read<AuthProvider>().loggedInUser.address = headQAdd;
      });
      setState(() => Global.isLoading = true);
      await context.read<AuthProvider>().loggedInUser.save(context);
      setState(() => Global.isLoading = false);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Adresse du siège mise à jour avec succès'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.primaryColor,
        progressIndicator: AppLoader(),
        child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: AppColors.lightestGreyColor,
              iconTheme: IconThemeData(
                color: AppColors.backButtonColor, //change your color here
              ),
              title: Text('Adresse du siège', style: AppStyles.blackTextStyle),
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
                                  padding: EdgeInsets.fromLTRB(16, 30, 16, 40),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Adresse du siège',
                                              style: AppStyles.blackTextStyle
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            Form(
                                              key: headQFormKey,
                                              child: FormFieldContainer(
                                                child: GooglePlacesAutocomplete(
                                                  initialValue: headQAdd,
                                                  validator: (value) =>
                                                      Validators.required(value,
                                                          errorText:
                                                              "Veuillez saisir l'adresse du siège"),
                                                  onSelect: (val) => this
                                                      .setState(
                                                          () => headQAdd = val),
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
                                              onPressed: onSave,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 0,
                                            ),
                                          ),
                                        ),
                                      ]))))));
            })));
  }
}
