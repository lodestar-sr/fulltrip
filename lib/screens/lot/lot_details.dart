import 'dart:collection';
import 'package:Fulltrip/widgets/lot/lot_screen_shell.dart';
import 'package:flutter/material.dart';

class LotDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LinkedHashMap<String, dynamic> args =
        ModalRoute.of(context).settings.arguments;

    return LotScreenShell(
      lot: args['lot'],
      companyName: args['company_name'],
    );
  }
}
