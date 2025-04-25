import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'result_controller.dart';

class ResultView extends GetView<ResultController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('识别结果'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: controller.shareResult,
          ),
          if (!controller.isFromHistory.value)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: controller.saveResult,
            ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // 图片显示
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: controller.getImage(),
                        ),
                      ),
                    ),
                    
                    // 识别结果列表
                    Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.results.length,
                        separatorBuilder: (context, index) => Divider(height: 1),
                        itemBuilder: (context, index) {
                          final result = controller.results[index];
                          final confidence = double.parse(result['confidence'].toString());
                          
                          return ListTile(
                            title: Text(
                              result['label'],
                              style: TextStyle(
                                fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            trailing: Text(
                              '${(confidence * 100).toStringAsFixed(1)}%',
                              style: TextStyle(
                                color: index == 0 ? Colors.blue : Colors.grey[600],
                                fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
} 