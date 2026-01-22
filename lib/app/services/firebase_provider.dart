import 'package:autoagent/app/model/user_location_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  Future<void> adicionarDados(UserLocationModel userLocation) async {
    // 1. Instanciar o Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 2. Referenciar a coleção e adicionar dados
    try {
      await firestore.collection('locations').doc(userLocation.id).set({
        'lat': userLocation.lat,
        'lng': userLocation.long,
        'timestamp': userLocation.timestamp,
      });
      print("Dados adicionados com sucesso!");
    } catch (e) {
      throw Exception("Erro ao adicionar dados: $e");
    }
  }
}
