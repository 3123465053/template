import 'package:get/get.dart';

class MainLogic extends GetxController{
  RxInt selectTabIndex=0.obs;


  changeTab(int index){
    selectTabIndex.value=index;
  }
}