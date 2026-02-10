import 'package:autoagent/app/model/user_location_model.dart';
import 'package:autoagent/app/modules/dashboard/controller/home_controller.dart';
import 'package:autoagent/app/services/firebase_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LocationService {
  LocationPermission? permission;
  bool serviceEnabled = false;
  Position? position;
  Timer? _locationTimer;
  bool _isTracking = false;
  late String vehicleId;
  late HomeController _homeController;

  Future<LocationService> init(String vehicleId) async {
    await Future.delayed(Duration(milliseconds: 500));
    _homeController = Get.find<HomeController>();
    this.vehicleId = vehicleId;
    await _initializeLocation();
    return this;
  }

  Future<void> _initializeLocation() async {
    try {
      // 1. Mostrar pop-up explicativo
      await _showLocationExplanationDialog();

      // 2. Verificar se o serviço de localização está ativado
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await _showLocationDisabledDialog();
        await Geolocator.openLocationSettings();

        // Aguardar e tentar novamente após retornar das configurações
        await Future.delayed(Duration(seconds: 2));
        serviceEnabled = await Geolocator.isLocationServiceEnabled();

        if (!serviceEnabled) {
          Get.snackbar('Erro', 'Localização permanece desativada');
          return;
        }
      }

      // 3. Verificar permissões
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return;
      }

      // Pega localização inicial
      await _fetchCurrentLocation();
    } catch (e) {
      print('Erro ao obter localização: $e');
    }
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      position = await Geolocator.getCurrentPosition(
        timeLimit: Duration(seconds: 10),
      );

      startTracking();

      UserLocationModel userLocationModel = _createUserLocationModel();
      await FirebaseProvider().adicionarDados(userLocationModel);

      _homeController.updateLocationStatus(true);
    } catch (e) {
      _homeController.updateLocationStatus(false);
      print('Erro ao buscar localização: $e');
    }
  }

  /// Inicia rastreamento contínuo do veículo
  void startTracking({Duration interval = const Duration(seconds: 10)}) {
    if (_isTracking) {
      return;
    }

    _isTracking = true;

    _locationTimer = Timer.periodic(interval, (_) async {
      await _fetchCurrentLocation();

      print(
        'Localização atualizada: ${position?.latitude}, ${position?.longitude}',
      );
    });
  }

  /// Para o rastreamento
  void stopTracking() {
    if (_isTracking) {
      _locationTimer?.cancel();
      _isTracking = false;
      print('Rastreamento parado');
      Get.snackbar('Info', 'Rastreamento parado');
    }
  }

  /// Verifica se está rastreando
  bool get isTracking => _isTracking;

  Future<void> _showLocationExplanationDialog() async {
    return Get.dialog(
      AlertDialog(
        title: Text('Localização Necessária'),
        content: Text(
          'Precisamos acessar sua localização para rastrear o veículo e fornecer dados em tempo real.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Entendi')),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _showLocationDisabledDialog() async {
    return Get.dialog(
      AlertDialog(
        title: Text('Localização Desativada'),
        content: Text(
          'A localização está desativada. Você será redirecionado para ativar nas configurações do dispositivo.',
        ),
        actions: [TextButton(onPressed: () => Get.back(), child: Text('OK'))],
      ),
      barrierDismissible: false,
    );
  }

  UserLocationModel _createUserLocationModel() {
    return UserLocationModel(
      id: vehicleId,
      lat: position?.latitude ?? 0.0,
      long: position?.longitude ?? 0.0,
      timestamp: DateTime.now(),
    );
  }
}
