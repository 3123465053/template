import 'package:get/get.dart';
import '../pages/main/binding.dart';
import '../pages/main/view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final pages = [

    GetPage(
        name: AppRoutes.MAIN,
        page: () => const MainPage(),
        binding: MainBinding()),

  ];
}
