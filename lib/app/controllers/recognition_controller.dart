import 'package:get/get.dart';
import '../services/recognition_service.dart';
import '../services/image_service.dart';

class RecognitionController extends GetxController {
  final RecognitionService _recognitionService = RecognitionService();
  final ImageService _imageService = ImageService();
  
  final isLoading = false.obs;
  final results = <Map<String, dynamic>>[].obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeService();
  }

  Future<void> _initializeService() async {
    try {
      await _recognitionService.initialize();
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> recognizeImage(String imagePath) async {
    if (!_recognitionService.isInitialized) {
      error.value = '识别服务未初始化';
      return;
    }

    try {
      isLoading.value = true;
      error.value = '';
      
      // 预处理图像
      final processedPath = await _imageService.preprocessImage(imagePath);
      
      // 执行识别
      final recognitionResults = await _recognitionService.recognizeImage(processedPath);
      
      // 更新结果
      results.assignAll(recognitionResults.map((result) => {
        'label': result['label'],
        'confidence': ((result['confidence'] as double) * 100).toStringAsFixed(1) + '%',
      }));
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _recognitionService.dispose();
    super.onClose();
  }
} 