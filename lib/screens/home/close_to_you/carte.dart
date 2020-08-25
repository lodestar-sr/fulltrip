import 'package:flutter/material.dart';

class Carte extends StatefulWidget {
  Carte({Key key}) : super(key: key);

  @override
  _CarteState createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Carte'),
    );
  }
}
