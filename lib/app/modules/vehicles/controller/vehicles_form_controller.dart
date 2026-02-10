import 'package:autoagent/app/modules/vehicles/data/model/vehicles_model.dart';
import 'package:autoagent/app/modules/vehicles/data/repository/vehicles_repository.dart';
import 'package:autoagent/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehiclesFormController extends GetxController {
  final VehiclesRepository _repository = VehiclesRepository();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placaController = TextEditingController();

  late var user;

  @override
  void onInit() {
    user = Get.arguments;
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    placaController.dispose();
    super.onClose();
  }

  Future<void> submitVehicle() async {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    if (user.email.isEmpty) {
      Get.snackbar('Erro', 'Usuario sem email valido');
      return;
    }

    final vehicle = VehiclesModel(
      name: nameController.text.trim(),
      email: user.email,
      createdAt: DateTime.now().toIso8601String(),
      placa: placaController.text.trim().toUpperCase(),
    );

    try {
      await _repository.createVehicle(vehicle);
      Get.snackbar('Sucesso', 'Veiculo criado com sucesso');
      formState.reset();
      nameController.clear();
      placaController.clear();
      Get.offAllNamed(Routes.HOME, arguments: user);
    } catch (e) {
      Get.snackbar('Erro', 'Nao foi possivel criar o veiculo');
    }
  }
}
