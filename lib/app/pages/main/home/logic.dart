import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/app/common/Widget/app_tips_widget.dart';
import 'package:template/app/routes/app_pages.dart';

class HomeLogic extends GetxController {
  TextEditingController editingController = TextEditingController();

  String url = "";
  //总次数
  RxInt count=0.obs;
  RxInt finshCount=0.obs;
  start() async{
    if (url.isEmpty) {
      AppTipsWidget.showToast('URl不能为空');
      return;
    }

    for(int i=0;i<count.value;i++){
     await Get.toNamed(AppRoutes.WEB, arguments: url);
     finshCount.value++;
     await Future.delayed(Duration(milliseconds: 1000));

    }

  }
}
