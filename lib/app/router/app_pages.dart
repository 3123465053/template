import 'package:get/get.dart';
import 'package:template/app/pages/other/intro/intro_binding.dart';
import 'package:template/app/pages/other/intro/intro_view.dart';
import '../pages/main/binding.dart';
import '../pages/main/view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final pages = [

    GetPage(
        name: AppRoutes.MAIN,
        page: () => const MainPage(),
        binding: MainBinding()),

    GetPage(
        name: AppRoutes.INTRO,
        page: () =>  IntroView(),
        binding: IntroBinding()),


  ];
}
