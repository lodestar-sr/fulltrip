import 'package:Fulltrip/data/models/lot.model.dart';
import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/util/global.dart';

class LotService {
  static Future<Lot> getLotByUid(String uid) async {
    final document =
        await Global.firestore.collection('lots').document(uid).get();
    return Lot.fromJson(document.data);
  }

  static Future<List<Lot>> getSearchLots(User user) async {
    final querySnapshot =
        await Global.firestore.collection('lots').getDocuments();
    return querySnapshot.documents
        .map((document) => Lot.fromJson(document.data))
        .where((lot) =>
            lot.proposedBy != user.uid &&
            !lot.reservedBy.contains(user.uid) &&
            lot.assignedTo == null)
        .toList();
  }

  static Future<List<Lot>> getProposedLots(User user) async {
    final querySnapshot = await Global.firestore
        .collection('lots')
        .where('proposed_by', isEqualTo: user.uid)
        .getDocuments();
    return querySnapshot.documents
        .map((document) => Lot.fromJson(document.data))
        .toList();
  }

  static Future<List<Lot>> getReservedLots(User user) async {
    final querySnapshot = await Global.firestore
        .collection('lots')
        .where('reserved_by', arrayContains: user.uid)
        .getDocuments();
    return querySnapshot.documents
        .map((document) => Lot.fromJson(document.data))
        .toList();
  }
}
