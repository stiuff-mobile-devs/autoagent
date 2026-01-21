import 'package:autoagent/app/modules/dashboard/controller/home_controller.dart';
import 'package:autoagent/app/modules/services/location_service.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationService>(() => LocationService());

    Get.lazyPut<HomeController>(() => HomeController());
  }
}
