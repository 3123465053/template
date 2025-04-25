import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/theme_service.dart';

class SettingsController extends GetxController {
  final _prefs = SharedPreferences.getInstance();
  final _themeService = Get.find<ThemeService>();
  
  // 设置项
  final isDarkMode = false.obs;
  final isAutoSave = true.obs;
  final maxHistoryCount = 50.obs;
  final imageQuality = 0.8.obs;
  final language = 'zh_CN'.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    isDarkMode.value = Get.isDarkMode;
  }

  Future<void> saveSettings() async {
    final prefs = await _prefs;
    
    await prefs.setBool('isAutoSave', isAutoSave.value);
    await prefs.setInt('maxHistoryCount', maxHistoryCount.value);
    await prefs.setDouble('imageQuality', imageQuality.value);
    await prefs.setString('language', language.value);
    
    Get.snackbar('成功', '设置已保存');
  }

  void toggleDarkMode() {
    _themeService.switchTheme();
    isDarkMode.value = Get.isDarkMode;
  }

  void toggleAutoSave() {
    isAutoSave.value = !isAutoSave.value;
    saveSettings();
  }

  void updateMaxHistoryCount(int value) {
    maxHistoryCount.value = value;
    saveSettings();
  }

  void updateImageQuality(double value) {
    imageQuality.value = value;
    saveSettings();
  }

  void updateLanguage(String value) {
    language.value = value;
    Get.updateLocale(Locale(value.split('_')[0], value.split('_')[1]));
    saveSettings();
  }

  void clearCache() async {
    try {
      // TODO: 实现清除缓存功能
      Get.snackbar('成功', '缓存已清除');
    } catch (e) {
      Get.snackbar('错误', '清除缓存失败：$e');
    }
  }

  void checkUpdate() async {
    try {
      // TODO: 实现检查更新功能
      Get.snackbar('提示', '当前已是最新版本');
    } catch (e) {
      Get.snackbar('错误', '检查更新失败：$e');
    }
  }

  void about() {
    Get.dialog(
      AlertDialog(
        title: Text('关于'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('版本：1.0.0'),
            SizedBox(height: 8),
            Text('开发者：Your Name'),
            SizedBox(height: 8),
            Text('联系方式：your@email.com'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('确定'),
          ),
        ],
      ),
    );
  }
} 