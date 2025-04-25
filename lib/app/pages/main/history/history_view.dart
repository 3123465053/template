import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'history_controller.dart';
import 'dart:io';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('历史记录'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: controller.deleteHistory,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.historyList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  '暂无历史记录',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.historyList.length,
          itemBuilder: (context, index) {
            final item = controller.historyList[index];
            return Dismissible(
              key: Key(item['id'] ?? index.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16),
                color: Colors.red,
                child: Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => controller.deleteItem(index),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(item['image']),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: Icon(Icons.error, color: Colors.grey),
                      );
                    },
                  ),
                ),
                title: Text(
                  item['result'] ?? '未知结果',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '置信度: ${(item['confidence'] * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      item['date'] ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Get.toNamed('/result', arguments: item);
                },
              ),
            );
          },
        );
      }),
    );
  }
} 