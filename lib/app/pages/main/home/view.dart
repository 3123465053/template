import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../common/Widget/app_bar_ext.dart';
import '../../../common/config/app_color.dart';
import 'logic.dart';
import 'package:dio/dio.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pageBackgroundColor,
      appBar: AppBar(
        title: Obx(()=>Text("${controller.finshCount}/${controller.count}")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: Get.width/2,child: TextField(
              onChanged: (value){
                print(value);
                controller.count.value=int.tryParse(value)??0;
              },
            ),),
            inputWidget(),
          ElevatedButton(onPressed: (){
            controller.start();
          }, child: Text("开始"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            Dio dio = Dio();
            var res = await dio.get("https://www.baidu.com/");
            print("fdsasds");
            print(res);
          } catch (e) {
            print("出错#$e");
          }
        },
      ),
    );
  }

  Widget inputWidget() {
    return TextField(
      controller: controller.editingController,
      onChanged: (value) {
        print("asfdydf");
        print(value);
        controller.url=value;
      },
      onSubmitted: (value) {
        controller.start();
      },
    );
  }
}
