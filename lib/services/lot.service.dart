import 'package:Fulltrip/data/models/lot.dart';
import 'package:Fulltrip/util/global.dart';

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
