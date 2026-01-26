import 'package:autoagent/app/modules/dashboard/bindings/home_bindings.dart';
import 'package:autoagent/app/modules/dashboard/ui/home_page.dart';
import 'package:autoagent/app/modules/login/bindings/login_bindings.dart';
import 'package:autoagent/app/modules/login/ui/login_page.dart';
import 'package:autoagent/app/modules/splash/bindings/splash_bindings.dart';
import 'package:autoagent/app/modules/splash/ui/splash_page.dart';
import 'package:autoagent/app/routes/app_routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      bindings: [SplashBindings()],
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      bindings: [HomeBindings()],
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      bindings: [LoginBindings()],
    ),
  ];
}
