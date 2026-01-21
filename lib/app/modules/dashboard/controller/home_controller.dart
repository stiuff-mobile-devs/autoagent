import 'package:autoagent/app/modules/services/location_service.dart';
import 'package:get/get.dart';

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

  late LocationService locationService;

  @override
  void onInit() {
    locationService = Get.find<LocationService>();
    locationService.init();

    super.onInit();
    // Inicialização ou carregamento de dados pode ser feito aqui
  }
}
