import 'package:autoagent/app/modules/dashboard/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
