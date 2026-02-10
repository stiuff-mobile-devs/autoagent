import 'package:autoagent/app/model/user_location_model.dart';
import 'package:autoagent/app/modules/vehicles/data/model/vehicles_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  Future<void> adicionarDados(UserLocationModel userLocation) async {
    // 1. Instanciar o Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 2. Referenciar a coleção e adicionar dados
    try {
      await firestore.collection('locations').doc(userLocation.id).set({
        'lat': userLocation.lat,
        'long': userLocation.long,
        'timestamp': userLocation.timestamp,
      });
      print("Dados adicionados com sucesso!");
    } catch (e) {
      throw Exception("Erro ao adicionar dados: $e");
    }
  }

  Future<List<Map<String, dynamic>>> findVehiclesByEmail(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore
          .collection('vehicles')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } catch (e) {
      throw Exception("Erro ao buscar veículos por email: $e");
    }
  }

  Future<void> createVehicle(VehiclesModel vehicle) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('vehicles').add(vehicle.toFirebase());
    } catch (e) {
      throw Exception("Erro ao criar veiculo: $e");
    }
  }
}
