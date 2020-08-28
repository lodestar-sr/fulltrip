import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/data/providers/auth.provider.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/widgets/cards/completed_lot_card.dart';
import 'package:Fulltrip/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedLots extends StatelessWidget {
  CompletedLots({Key key}) : super(key: key);

  List<Widget> listLotItems(BuildContext context) {
    final userUid = Provider.of<AuthProvider>(context).loggedInUser.uid;
    List<Widget> list = [];

    Global.reservedLots.forEach((lot) {
      if (lot.getReservedStatus(userUid) == ReservedLotStatus.ongoing) {
        list.add(
          CompletedLotCard(
            lot: lot,
            companyName: lot.proposedCompanyName,
          ),
        );
      }
    });

    if (list.length == 0) {
      list.add(NoData());
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: listLotItems(context),
    );
  }
}
