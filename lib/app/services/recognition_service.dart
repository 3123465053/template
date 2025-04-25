import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class RecognitionService {
  static final RecognitionService _instance = RecognitionService._internal();
  factory RecognitionService() => _instance;
  RecognitionService._internal();

  Interpreter? _interpreter;
  List<String>? _labels;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 加载模型
      _interpreter = await Interpreter.fromAsset('assets/models/mobilenet_v1_1.0_224.tflite');
      
      // 加载标签
      final labelsData = await rootBundle.loadString('assets/models/labels.txt');
      _labels = labelsData.split('\n');
      
      _isInitialized = true;
    } catch (e) {
      throw Exception('初始化识别服务失败：$e');
    }
  }

  Future<List<Map<String, dynamic>>> recognizeImage(String imagePath) async {
    if (!_isInitialized) {
      throw Exception('识别服务未初始化');
    }

    try {
      // 读取和预处理图像
      final imageData = await _preprocessImage(imagePath);
      
      // 准备输入数据
      final input = [imageData];
      
      // 准备输出数据
      final output = List.filled(1 * 1001, 0.0).reshape([1, 1001]);
      
      // 运行推理
      _interpreter!.run(input, output);
      
      // 处理结果
      final results = _processResults(output[0] as List<double>);
      
      return results;
    } catch (e) {
      throw Exception('图像识别失败：$e');
    }
  }

  Future<List<double>> _preprocessImage(String imagePath) async {
    // 读取图像
    final imageFile = File(imagePath);
    final imageBytes = await imageFile.readAsBytes();
    final image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception('无法解码图像');
    }

    // 调整大小为 224x224
    final resized = img.copyResize(
      image,
      width: 224,
      height: 224,
      interpolation: img.Interpolation.linear,
    );

    // 转换为浮点数数组并进行归一化
    final buffer = List<double>.filled(1 * 224 * 224 * 3, 0);
    var index = 0;

    for (var y = 0; y < resized.height; y++) {
      for (var x = 0; x < resized.width; x++) {
        final pixel = resized.getPixel(x, y);
        // 归一化到 [-1, 1] 范围
        buffer[index++] = (pixel.r - 127.5) / 127.5;
        buffer[index++] = (pixel.g - 127.5) / 127.5;
        buffer[index++] = (pixel.b - 127.5) / 127.5;
      }
    }

    return buffer;
  }

  List<Map<String, dynamic>> _processResults(List<double> outputs) {
    // 创建 (index, score) 对的列表
    final List<MapEntry<int, double>> indexed = [];
    for (var i = 0; i < outputs.length; i++) {
      indexed.add(MapEntry(i, outputs[i]));
    }

    // 按分数排序
    indexed.sort((a, b) => b.value.compareTo(a.value));

    // 返回前5个结果
    return indexed.take(5).map((entry) {
      return {
        'label': _labels![entry.key],
        'confidence': entry.value,
      };
    }).toList();
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _isInitialized = false;
  }
} 