import 'package:cloud_firestore/cloud_firestore.dart';

class VehiclesModel {
  String? id;
  String name;
  String email;
  String createdAt;
  String placa;

  VehiclesModel({
    this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.placa,
  });

  VehiclesModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'] ?? '',
      email = json['email'] ?? '',
      createdAt = json['createdAt'] ?? '',
      placa = json['placa'] ?? '';

  static VehiclesModel fromFirebase(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return VehiclesModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      createdAt: data['createdAt'] ?? '',
      placa: data['placa'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['placa'] = this.placa;
    return data;
  }

  Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'email': email,
      'createdAt': createdAt,
      'placa': placa,
    };
  }
}
