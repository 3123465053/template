import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageService {
  static final ImageService _instance = ImageService._internal();
  factory ImageService() => _instance;
  ImageService._internal();

  /// 预处理图像
  Future<String> preprocessImage(String imagePath, {double quality = 0.8}) async {
    try {
      // 读取图像
      final File imageFile = File(imagePath);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);
      
      if (image == null) {
        throw Exception('无法解码图像');
      }

      // 调整图像大小
      final img.Image resized = img.copyResize(
        image,
        width: 224,  // MobileNet 模型要求的输入尺寸
        height: 224,
        interpolation: img.Interpolation.linear,
      );

      // 调整亮度和对比度
      final img.Image enhanced = _enhanceImage(resized);

      // 保存处理后的图像
      final String processedPath = await _saveProcessedImage(enhanced, quality);
      
      return processedPath;
    } catch (e) {
      throw Exception('图像预处理失败：$e');
    }
  }

  /// 增强图像
  img.Image _enhanceImage(img.Image image) {
    // 调整亮度和对比度
    final img.Image enhanced = img.copyResize(image, interpolation: img.Interpolation.linear);
    
    // 计算直方图
    final histogram = List<int>.filled(256, 0);
    for (var y = 0; y < enhanced.height; y++) {
      for (var x = 0; x < enhanced.width; x++) {
        final pixel = enhanced.getPixel(x, y);
        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();
        
        histogram[r]++;
        histogram[g]++;
        histogram[b]++;
      }
    }

    // 计算累积直方图
    final cdf = List<int>.filled(256, 0);
    cdf[0] = histogram[0];
    for (var i = 1; i < 256; i++) {
      cdf[i] = cdf[i - 1] + histogram[i];
    }

    // 归一化
    final cdfMin = cdf[0];
    final cdfMax = cdf[255];
    final cdfRange = cdfMax - cdfMin;

    // 应用直方图均衡化
    for (var y = 0; y < enhanced.height; y++) {
      for (var x = 0; x < enhanced.width; x++) {
        final pixel = enhanced.getPixel(x, y);
        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();

        final newR = ((cdf[r] - cdfMin) * 255 / cdfRange).round();
        final newG = ((cdf[g] - cdfMin) * 255 / cdfRange).round();
        final newB = ((cdf[b] - cdfMin) * 255 / cdfRange).round();

        final color = img.ColorUint8.rgb(newR, newG, newB);
        enhanced.setPixel(x, y, color);
      }
    }

    return enhanced;
  }

  /// 保存处理后的图像
  Future<String> _saveProcessedImage(img.Image image, double quality) async {
    try {
      final directory = await getTemporaryDirectory();
      final String fileName = 'processed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = '${directory.path}/$fileName';

      // 将图像编码为JPEG格式
      final List<int> jpegBytes = img.encodeJpg(image, quality: (quality * 100).round());
      
      // 保存文件
      final File file = File(filePath);
      await file.writeAsBytes(jpegBytes);

      return filePath;
    } catch (e) {
      throw Exception('保存处理后的图像失败：$e');
    }
  }

  /// 获取图像信息
  Future<Map<String, dynamic>> getImageInfo(String imagePath) async {
    try {
      final File imageFile = File(imagePath);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);
      
      if (image == null) {
        throw Exception('无法解码图像');
      }

      return {
        'width': image.width,
        'height': image.height,
        'format': image.format.name,
        'size': imageBytes.length,
        'aspectRatio': image.width / image.height,
      };
    } catch (e) {
      throw Exception('获取图像信息失败：$e');
    }
  }
} 