import 'package:autoagent/app/services/firebase_provider.dart';

class HomeRepository {
  HomeRepository();
  FirebaseProvider firebaseProvider = FirebaseProvider();

  Future<List<Map<String, dynamic>>> findVehiclesByEmail(String email) async {
    return await firebaseProvider.findVehiclesByEmail(email);
  }
}
