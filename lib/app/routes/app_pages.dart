import 'package:get/get.dart';
import '../pages/main/binding.dart';
import '../pages/main/view.dart';
part 'app_routes.dart';

class AppPages {

  static final Pages = [  GetPage(
      name: AppRoutes.MAIN,
      page: () => const MainPage(),
      binding: MainBinding()),

  ];
} 