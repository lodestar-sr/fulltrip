import 'package:flutter/material.dart';
import 'package:fulltrip/util/global.dart';
import 'package:fulltrip/util/size_config.dart';
import 'package:fulltrip/util/theme.dart';
import 'package:fulltrip/util/validators/validators.dart';
import 'package:fulltrip/widgets/form_field_container/index.dart';
import 'package:fulltrip/widgets/google_place_autocomplete/google_place_autocomplete.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AdresseDuSiege extends StatefulWidget {
  AdresseDuSiege({Key key}) : super(key: key);

  @override
  _AdresseDuSiegeState createState() => _AdresseDuSiegeState();
}

class _AdresseDuSiegeState extends State<AdresseDuSiege> {
  String headQAdd = '';
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
              title: Text('Adresse du siège'),
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
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text('Adresse du siège'),
                                        FormFieldContainer(
                                          padding: EdgeInsets.only(
                                              right: 16, left: 16),
                                          child: GooglePlacesAutocomplete(
                                            initialValue:
                                                Global.lotForm.startingAddress,
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 13, 26, 13),
                                              child: Image.asset(
                                                  'assets/images/locationDeparture.png',
                                                  width: 13,
                                                  height: 13),
                                            ),
                                            validator: (value) =>
                                                Validators.required(value,
                                                    errorText:
                                                        'Adresse de départ est requis'),
                                            onSelect: (val) => this
                                                .setState(() => headQAdd = val),
                                          ),
                                        ),
                                      ]))))));
            })));
  }
}
