import 'dart:async';

import 'package:autoagent/app/routes/app_routes.dart';
import 'package:autoagent/app/services/google_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  final int splashDuration = 2; // Duração do splash em segundos
  final RxDouble opacity = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    Future.microtask(() => opacity.value = 1.0);
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Primeiro verifica se o Firebase já tem um usuário persistido
    var currentUser = FirebaseAuth.instance.currentUser;

    // Se não tiver, tenta o login silencioso do Google
    currentUser ??= (await GoogleService().signInSilently()) as User?;

    // Redireciona conforme o resultado
    if (currentUser != null) {
      Get.offAllNamed(Routes.HOME, arguments: currentUser);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
