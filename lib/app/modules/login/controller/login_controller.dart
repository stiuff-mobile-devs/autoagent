import 'package:autoagent/app/modules/user/model/user_model.dart';
import 'package:autoagent/app/modules/user/repository/user_repository.dart';
import 'package:autoagent/app/services/google_service.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final UserRepository _repository = UserRepository();
  final GoogleService _signInService = GoogleService();

  RxBool isLoading = false.obs;

  Future<void> trySignInWithGoogle() async {
    isLoading(true);
    try {
      UserModel? user = await _signInService.signInWithGoogle();
      if (user != null) {
        await _saveUser(user);
        _goToHomePage();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> _saveUser(UserModel user) async {
    UserModel? isSaved = await _repository.getUser(user.id);
    if (isSaved == null) {
      await _repository.addUser(user);
    }
  }

  _goToHomePage() {
    Get.offAllNamed(Routes.HOME);
  }
}
