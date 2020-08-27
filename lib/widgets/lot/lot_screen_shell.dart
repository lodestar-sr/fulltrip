import 'package:Fulltrip/widgets/lot/lot_widget.dart';
import 'package:Fulltrip/data/models/distance_time.model.dart';
import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LotScreenShell extends StatefulWidget {
  final Lot lot;
  final String companyName;
  final Widget acceptButton;
  final Widget rejectButton;

  LotScreenShell({
    @required this.lot,
    this.companyName,
    this.acceptButton,
    this.rejectButton,
  });

  @override
  State<StatefulWidget> createState() => _LotScreenShellState();
}

class _LotScreenShellState extends State<LotScreenShell> {
  Lot lot;

  final myFormat = DateFormat('d/MM');
  @override
  void initState() {
    lot = widget.lot;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColors.backButtonColor, //change your color here
          ),
          title: Text('Détails du lot',
              style: AppStyles.blackTextStyle
                  .copyWith(fontWeight: FontWeight.w500)),
          backgroundColor: AppColors.lightestGreyColor,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LotWidget(
                  lot: lot,
                  companyName: widget.companyName,
                ),
                widget.acceptButton ?? SizedBox(),
                widget.rejectButton ?? SizedBox(),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
