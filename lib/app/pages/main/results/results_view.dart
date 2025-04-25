import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'results_controller.dart';

class ResultsView extends GetView<ResultsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('识别结果'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: controller.saveResult,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: controller.shareResult,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 显示选择的图片
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Image.file(
                File(controller.imagePath),
                fit: BoxFit.contain,
              ),
            ),
            // 识别结果
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '识别结果',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ...controller.recognitionResults.map((result) {
                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    result['label'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${(result['confidence'] * 100).toStringAsFixed(1)}%',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                result['description'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
} 