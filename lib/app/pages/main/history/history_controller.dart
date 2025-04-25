import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/storage_service.dart';

class HistoryController extends GetxController {
  final StorageService _storageService = StorageService();
  final historyList = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    try {
      isLoading.value = true;
      final history = await _storageService.loadHistory();
      historyList.value = history;
    } catch (e) {
      Get.snackbar('错误', '加载历史记录失败：$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteHistory() async {
    try {
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: Text('确认删除'),
          content: Text('确定要删除所有历史记录吗？此操作不可恢复。'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text('删除'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await _storageService.deleteHistory();
        historyList.clear();
        Get.snackbar('成功', '历史记录已删除');
      }
    } catch (e) {
      Get.snackbar('错误', '删除历史记录失败：$e');
    }
  }

  Future<void> deleteItem(int index) async {
    try {
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: Text('确认删除'),
          content: Text('确定要删除这条记录吗？'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text('删除'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        historyList.removeAt(index);
        await _storageService.saveHistory(historyList);
        Get.snackbar('成功', '记录已删除');
      }
    } catch (e) {
      Get.snackbar('错误', '删除记录失败：$e');
    }
  }

  void viewHistoryDetail(Map<String, dynamic> item) {
    Get.toNamed('/results', arguments: item);
  }

  void clearHistory() {
    Get.dialog(
      AlertDialog(
        title: Text('确认清空'),
        content: Text('是否确认清空所有历史记录？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              historyList.clear();
              Get.back();
              Get.snackbar('成功', '历史记录已清空');
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }
} 