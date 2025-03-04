import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/config/app_color.dart';
import 'home/view.dart';
import 'logic.dart';
import 'me/view.dart';

class MainPage extends GetView<MainLogic> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() =>
          IndexedStack(
            index: controller.selectTabIndex.value,
            children: const [
              HomePage(),
              MePage(),
            ],
          )),
      bottomNavigationBar: Obx(() =>
          BottomNavigationBar(
              backgroundColor: AppColor.pageBackgroundColor,
              onTap: (index) {
                controller.changeTab(index);
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.selectTabIndex.value,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "我的"),
              ])),
    );
  }
}
