import 'package:autoagent/app/modules/user/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {
  static String collection = "users";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> create(UserModel user) async {
    await _firestore.doc("$collection/${user.id}").set(user.toJson());
  }

  Future<UserModel?> get(String id) async {
    try {
      var doc = await _firestore.doc("$collection/$id").get();
      if (!doc.exists) return null;
      return UserModel.fromJson(doc.data()!, doc.id);
    } catch (e) {
      return null;
    }
  }
}
