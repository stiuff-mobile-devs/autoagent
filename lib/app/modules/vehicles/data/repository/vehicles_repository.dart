import 'package:autoagent/app/modules/vehicles/data/model/vehicles_model.dart';
import 'package:autoagent/app/services/firebase_provider.dart';

class VehiclesRepository {
  VehiclesRepository();
  FirebaseProvider firebaseProvider = FirebaseProvider();
  Future<List<Map<String, dynamic>>> findVehiclesByEmail(String email) async {
    return await firebaseProvider.findVehiclesByEmail(email);
  }

  Future<void> createVehicle(VehiclesModel vehicle) async {
    await firebaseProvider.createVehicle(vehicle);
  }
}
