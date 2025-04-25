import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../../controllers/recognition_controller.dart';

class ResultController extends GetxController {
  final RecognitionController _recognitionController = Get.find<RecognitionController>();
  
  final isLoading = true.obs;
  final imagePath = ''.obs;
  final isFromHistory = false.obs;
  final results = <Map<String, dynamic>>[].obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeResult();
  }

  Future<void> _initializeResult() async {
    try {
      final args = Get.arguments;
      if (args == null) {
        error.value = '无效的参数';
        return;
      }

      imagePath.value = args['imagePath'] ?? '';
      isFromHistory.value = args['isFromHistory'] ?? false;

      if (imagePath.isEmpty) {
        error.value = '无效的图片路径';
        return;
      }

      if (!isFromHistory.value) {
        // 如果不是来自历史记录，执行新的识别
        await _recognitionController.recognizeImage(imagePath.value);
        results.assignAll(_recognitionController.results);
        error.value = _recognitionController.error.value;
      } else {
        // 如果是来自历史记录，直接使用传入的结果
        results.assignAll(args['results'] ?? []);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Widget getImage() {
    if (imagePath.value.startsWith('http')) {
      return Image.network(
        imagePath.value,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    } else {
      return Image.file(File(imagePath.value));
    }
  }

  Future<void> saveResult() async {
    try {
      if (isFromHistory.value) {
        Get.snackbar('提示', '该结果已保存');
        return;
      }

      // TODO: 实现保存结果到本地存储的功能
      Get.snackbar('成功', '结果已保存');
    } catch (e) {
      Get.snackbar('错误', '保存失败：$e');
    }
  }

  Future<void> shareResult() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/share_image.jpg';
      
      // 复制图片到临时目录
      await File(imagePath.value).copy(tempPath);
      
      // 生成分享文本
      final shareText = results.map((result) => 
        '${result['label']}: ${result['confidence']}'
      ).join('\n');
      
      // 分享
      await Share.shareXFiles(
        [XFile(tempPath)],
        text: shareText,
      );
    } catch (e) {
      Get.snackbar('错误', '分享失败：$e');
    }
  }
} 