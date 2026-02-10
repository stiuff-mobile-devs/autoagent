import 'package:autoagent/app/modules/vehicles/controller/vehicles_form_controller.dart';
import 'package:get/get.dart';

class VehiclesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehiclesFormController>(() => VehiclesFormController());
  }
}
