import 'package:get/get.dart';
import '../controllers/recognition_controller.dart';
import '../controllers/navigation_controller.dart';
import '../services/theme_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // 注册 ThemeService
    Get.put(ThemeService(), permanent: true);
    
    // 注册 RecognitionController
    Get.put(RecognitionController(), permanent: true);
    
    // 注册导航控制器
    Get.put(NavigationController(), permanent: true);
  }
} 