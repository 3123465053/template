import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import '../../../services/image_service.dart';

class EditorController extends GetxController {
  final ImageService _imageService = ImageService();
  
  final imagePath = ''.obs;
  final isLoading = false.obs;
  final rotationAngle = 0.0.obs;
  final flipHorizontal = false.obs;
  final flipVertical = false.obs;
  final brightness = 0.0.obs;
  final contrast = 1.0.obs;
  final cropRect = Rect.zero.obs;
  final isCropping = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['imagePath'] != null) {
      imagePath.value = args['imagePath'];
    }
  }

  Future<void> rotateImage(double angle) async {
    try {
      isLoading.value = true;
      rotationAngle.value = (rotationAngle.value + angle) % 360;
      
      final File imageFile = File(imagePath.value);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);
      
      if (image == null) {
        throw Exception('无法解码图像');
      }

      img.Image rotated = img.copyRotate(image, angle: angle.toInt());
      final String newPath = await _saveImage(rotated);
      imagePath.value = newPath;
    } catch (e) {
      Get.snackbar('错误', '旋转图片失败：$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> flipImage(bool horizontal) async {
    try {
      isLoading.value = true;
      
      if (horizontal) {
        flipHorizontal.value = !flipHorizontal.value;
      } else {
        flipVertical.value = !flipVertical.value;
      }

      final File imageFile = File(imagePath.value);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);
      
      if (image == null) {
        throw Exception('无法解码图像');
      }

      final img.Image flipped = horizontal 
          ? img.flipHorizontal(image)
          : img.flipVertical(image);

      final String newPath = await _saveImage(flipped);
      imagePath.value = newPath;
    } catch (e) {
      Get.snackbar('错误', '翻转图片失败：$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> adjustBrightness(double value) async {
    try {
      isLoading.value = true;
      brightness.value = value;

      final File imageFile = File(imagePath.value);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);
      
      if (image == null) {
        throw Exception('无法解码图像');
      }

      final img.Image adjusted = img.adjustColor(image, brightness: value.toInt());
      
      final String newPath = await _saveImage(adjusted);
      imagePath.value = newPath;
    } catch (e) {
      Get.snackbar('错误', '调整亮度失败：$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> adjustContrast(double value) async {
    try {
      isLoading.value = true;
      contrast.value = value;

      final File imageFile = File(imagePath.value);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);
      
      if (image == null) {
        throw Exception('无法解码图像');
      }

      final img.Image adjusted = img.adjustColor(image, contrast: value);
      
      final String newPath = await _saveImage(adjusted);
      imagePath.value = newPath;
    } catch (e) {
      Get.snackbar('错误', '调整对比度失败：$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cropImage(Rect rect) async {
    try {
      isLoading.value = true;
      cropRect.value = rect;

      final File imageFile = File(imagePath.value);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);
      
      if (image == null) {
        throw Exception('无法解码图像');
      }

      final img.Image cropped = img.copyCrop(
        image,
        x: rect.left.toInt(),
        y: rect.top.toInt(),
        width: rect.width.toInt(),
        height: rect.height.toInt(),
      );
      
      final String newPath = await _saveImage(cropped);
      imagePath.value = newPath;
      isCropping.value = false;
    } catch (e) {
      Get.snackbar('错误', '裁剪图片失败：$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> _saveImage(img.Image image) async {
    try {
      final directory = await getTemporaryDirectory();
      final String fileName = 'edited_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = '${directory.path}/$fileName';

      final List<int> jpegBytes = img.encodeJpg(image, quality: 90);
      final File file = File(filePath);
      await file.writeAsBytes(jpegBytes);

      return filePath;
    } catch (e) {
      throw Exception('保存图片失败：$e');
    }
  }

  Future<void> saveChanges() async {
    try {
      isLoading.value = true;
      
      // 获取应用文档目录
      final directory = await getApplicationDocumentsDirectory();
      final String fileName = 'edited_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String savedPath = '${directory.path}/images/$fileName';

      // 确保目标目录存在
      final imageDir = Directory('${directory.path}/images');
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }

      // 复制编辑后的图片到永久存储
      await File(imagePath.value).copy(savedPath);

      // 返回编辑后的图片路径
      Get.back(result: savedPath);
    } catch (e) {
      Get.snackbar('错误', '保存更改失败：$e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // 清理临时文件
    try {
      if (imagePath.value.contains('edited_')) {
        File(imagePath.value).deleteSync();
      }
    } catch (e) {
      print('清理临时文件失败：$e');
    }
    super.onClose();
  }
} 