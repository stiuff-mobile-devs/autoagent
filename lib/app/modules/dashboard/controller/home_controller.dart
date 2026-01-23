import 'package:autoagent/app/services/location_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  // Variáveis reativas de dados OBD2
  final RxDouble speed = 85.0.obs;
  final RxInt rpm = 2500.obs;
  final RxInt engineTemp = 89.obs;
  final RxInt throttlePosition = 45.obs;
  final RxDouble batteryVoltage = 13.8.obs;
  final RxInt fuelLevel = 75.obs;
  final RxInt airTemp = 22.obs;
  final RxBool isConnected = true.obs;
  final RxString deviceName = 'BUS-UFF-1'.obs;
  final RxInt errorCodesCount = 0.obs;
  final RxBool systemHealthy = true.obs;

  // Status de localização
  final RxString locationStatus =
      'success'.obs; // 'success', 'warning', 'error'
  final RxInt failedAttempts = 0.obs;

  late LocationService locationService = LocationService();

  @override
  void onInit() {
    locationService.init();

    super.onInit();
  }

  /// Atualiza o status da localização
  void updateLocationStatus(bool success) {
    if (success) {
      locationStatus.value = 'success';
      failedAttempts.value = 0;
    } else {
      failedAttempts.value++;
      if (failedAttempts.value == 1) {
        locationStatus.value = 'warning';
      } else if (failedAttempts.value >= 2) {
        locationStatus.value = 'error';
      }
    }
  }

  /// Retorna a cor do status
  Color getLocationStatusColor() {
    switch (locationStatus.value) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.amber;
      case 'error':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  /// Atualiza manualmente a localização
  void refreshLocation() {
    // TODO: Implementar lógica de atualização
  }
}
