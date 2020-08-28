import 'package:Fulltrip/data/models/user.model.dart';
import 'package:Fulltrip/util/global.dart';

class UserService {
  static Future<String> getCompanyNameByUid(String userUid) async {
    final document =
        await Global.firestore.collection('users').document(userUid).get();
    return document.data['raisonSociale'];
  }
}
