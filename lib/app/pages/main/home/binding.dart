import 'package:get/get.dart';

import 'logic.dart';
class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeLogic());
  }

}