import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/widgets/cards/completed_lot_card.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/widgets/no_data.dart';
import 'package:flutter/material.dart';

class CompletedLots extends StatefulWidget {
  CompletedLots({Key key}) : super(key: key);

  @override
  _CompletedLotsState createState() => _CompletedLotsState();
}

class _CompletedLotsState extends State<CompletedLots> {
  List<Widget> listLotItems() {
    List<Widget> list = [];

    Global.proposedLots.forEach((lot) {
      if (lot.getProposedStatus() == ProposedLotStatus.ongoing)
        list.add(
          CompletedLotCard(
            lot: lot,
            companyName: lot.assignedCompanyName,
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
