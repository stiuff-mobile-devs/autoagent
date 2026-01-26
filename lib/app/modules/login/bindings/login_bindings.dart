import 'package:autoagent/app/modules/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
