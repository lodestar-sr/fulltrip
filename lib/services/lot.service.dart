import 'dart:convert';
import 'package:fulltrip/data/models/lot.dart';
import 'package:fulltrip/util/global.dart';
import 'package:http/http.dart' as http;

class LotService {

  static LotService _lotService;

  static LotService getInstance() {
    if (_lotService != null) {
      return _lotService;
    }

    _lotService = new LotService();
    return _lotService;
  }

  Future<List<Lot>> getAllLots() async {
    List<Lot> lots = [];
    final querySnapshot = await Global.firestore.collection('lots').getDocuments();
    lots = querySnapshot.documents.map((element) => Lot.fromJson(element.data)).toList();
    return lots;
  }
}