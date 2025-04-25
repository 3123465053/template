import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/navigation_controller.dart';
import 'home/home_view.dart';
import 'history/history_view.dart';
import 'settings/settings_view.dart';

class MainView extends GetView<NavigationController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: const [
          HomeView(),
          HistoryView(),
          SettingsView(),
        ],
      )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: '历史',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '设置',
            ),
          ],
        ),
      ),
    );
  }
} 