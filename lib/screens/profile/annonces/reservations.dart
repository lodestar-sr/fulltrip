import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/services/user.service.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/widgets/cards/reservation_card.dart';
import 'package:Fulltrip/widgets/no_data.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Reservations extends StatefulWidget {
  Reservations({Key key}) : super(key: key);

  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  List<Widget> reservationList = [];

  void buildReservationList() async {
    setState(() => Global.isLoading = true);
    List<Widget> list = [];

    for (final lot in Global.proposedLots) {
      if (lot.getProposedStatus() != ProposedLotStatus.validating) {
        continue;
      }

      final reservedUsers = Set<String>.from(lot.reservedBy)
        ..removeAll(lot.refusedReservationFor);

      for (final userUid in reservedUsers) {
        list.add(
          ReservationCard(
            lot: lot,
            userUid: userUid,
            companyName: await UserService.getCompanyNameByUid(userUid),
          ),
        );
      }
    }

    if (list.length == 0) {
      list.add(NoData());
    }
    if (mounted) {
      setState(() {
        reservationList = list;
        Global.isLoading = false;
      });
    } else {
      Global.isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    buildReservationList();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: reservationList,
      ),
    );
  }
}
