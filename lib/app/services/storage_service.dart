import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static const String _historyFileName = 'recognition_history.json';
  
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_historyFileName');
  }

  Future<List<Map<String, dynamic>>> loadHistory() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error loading history: $e');
      return [];
    }
  }

  Future<void> saveHistory(List<Map<String, dynamic>> history) async {
    try {
      final file = await _localFile;
      final jsonString = json.encode(history);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving history: $e');
      rethrow;
    }
  }

  Future<void> addToHistory(Map<String, dynamic> result) async {
    try {
      final history = await loadHistory();
      
      // 如果是本地文件路径，需要将图片复制到应用程序目录
      if (result['image'].startsWith('/')) {
        final imagePath = await _saveImage(File(result['image']));
        result = Map<String, dynamic>.from(result);
        result['image'] = imagePath;
      }
      
      // 添加到历史记录开头
      history.insert(0, result);
      
      // 限制历史记录数量（例如保留最近50条）
      if (history.length > 50) {
        history.removeRange(50, history.length);
      }
      
      await saveHistory(history);
    } catch (e) {
      print('Error adding to history: $e');
      rethrow;
    }
  }

  Future<String> _saveImage(File sourceFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageName = 'recognition_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final targetPath = '${directory.path}/images/$imageName';
      
      // 确保目标目录存在
      final imageDir = Directory('${directory.path}/images');
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }
      
      // 复制图片文件
      await sourceFile.copy(targetPath);
      return targetPath;
    } catch (e) {
      print('Error saving image: $e');
      rethrow;
    }
  }

  Future<void> deleteHistory() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        await file.delete();
      }
      
      // 删除所有保存的图片
      final directory = await getApplicationDocumentsDirectory();
      final imageDir = Directory('${directory.path}/images');
      if (await imageDir.exists()) {
        await imageDir.delete(recursive: true);
      }
    } catch (e) {
      print('Error deleting history: $e');
      rethrow;
    }
  }
} 