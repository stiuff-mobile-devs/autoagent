import 'package:autoagent/app/modules/vehicles/data/model/vehicles_model.dart';
import 'package:autoagent/app/modules/vehicles/data/repository/vehicles_repository.dart';
import 'package:autoagent/app/routes/app_routes.dart';
import 'package:autoagent/app/utils/app_snackbar.dart';
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
      AppSnackbar.show(
        'Erro',
        'Usuario sem email valido',
        type: SnackType.error,
      );
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
      AppSnackbar.show(
        'Sucesso',
        'Veiculo criado com sucesso',
        type: SnackType.success,
      );
      formState.reset();
      nameController.clear();
      placaController.clear();
      Get.offAllNamed(Routes.HOME, arguments: user);
    } catch (e) {
      AppSnackbar.show(
        'Erro',
        'Nao foi possivel criar o veiculo',
        type: SnackType.error,
      );
    }
  }
}
