import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/widgets/cards/ongoing_lot_card.dart';
import 'package:Fulltrip/widgets/no_data.dart';
import 'package:flutter/material.dart';

class OngoingLots extends StatelessWidget {
  OngoingLots({Key key}) : super(key: key);

  List<Widget> listLotItems() {
    List<Widget> list = [];

    Global.proposedLots.forEach((lot) {
      final ProposedLotStatus status = lot.getProposedStatus();
      list.add(
        OngoingLotCard(
          lot: lot,
          status: status.string,
          companyName: status == ProposedLotStatus.ongoing
              ? lot.assignedCompanyName
              : null,
        ),
      );
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
      children: listLotItems(),
    );
  }
}
