import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';

class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final recentImages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentRecords();
  }

  // 加载最近的识别记录
  Future<void> loadRecentRecords() async {
    try {
      // TODO: 从本地存储加载历史记录
      recentImages.clear();
    } catch (e) {
      EasyLoading.showError('加载历史记录失败');
    }
  }

  // 拍照
  Future<void> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (photo != null) {
        final File imageFile = File(photo.path);
        if (await imageFile.exists()) {
          Get.toNamed('/result', arguments: {
            'imagePath': photo.path,
            'isFromHistory': false,
          });
        } else {
          EasyLoading.showError('图片获取失败');
        }
      }
    } catch (e) {
      EasyLoading.showError('拍照失败：${e.toString()}');
    }
  }

  // 从相册选择
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        final File imageFile = File(image.path);
        if (await imageFile.exists()) {
          Get.toNamed('/result', arguments: {
            'imagePath': image.path,
            'isFromHistory': false,
          });
        } else {
          EasyLoading.showError('图片获取失败');
        }
      }
    } catch (e) {
      EasyLoading.showError('选择图片失败：${e.toString()}');
    }
  }

  // 查看历史记录详情
  void viewHistoryDetail(Map<String, dynamic> item) {
    Get.toNamed('/result', arguments: {
      'imagePath': item['imagePath'],
      'results': item['results'],
      'isFromHistory': true,
    });
  }
} 