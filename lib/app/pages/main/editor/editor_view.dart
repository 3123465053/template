import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'editor_controller.dart';

class EditorView extends GetView<EditorController> {
  const EditorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑图片'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: controller.saveChanges,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Expanded(
              child: _buildImagePreview(),
            ),
            _buildToolbar(),
          ],
        );
      }),
    );
  }

  Widget _buildImagePreview() {
    return InteractiveViewer(
      child: Center(
        child: Stack(
          children: [
            Image.file(
              File(controller.imagePath.value),
              fit: BoxFit.contain,
            ),
            if (controller.isCropping.value)
              _buildCropOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildCropOverlay() {
    return Positioned.fill(
      child: GestureDetector(
        onPanUpdate: (details) {
          // TODO: 实现裁剪区域拖动逻辑
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
          ),
          child: Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildToolButton(
                icon: Icons.rotate_left,
                label: '向左旋转',
                onPressed: () => controller.rotateImage(-90),
              ),
              _buildToolButton(
                icon: Icons.rotate_right,
                label: '向右旋转',
                onPressed: () => controller.rotateImage(90),
              ),
              _buildToolButton(
                icon: Icons.flip,
                label: '水平翻转',
                onPressed: () => controller.flipImage(true),
              ),
              _buildToolButton(
                icon: Icons.flip_camera_android,
                label: '垂直翻转',
                onPressed: () => controller.flipImage(false),
              ),
              _buildToolButton(
                icon: Icons.crop,
                label: '裁剪',
                onPressed: () => controller.isCropping.toggle(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              _buildSlider(
                label: '亮度',
                value: controller.brightness.value,
                min: -1.0,
                max: 1.0,
                onChanged: controller.adjustBrightness,
              ),
              SizedBox(height: 8),
              _buildSlider(
                label: '对比度',
                value: controller.contrast.value,
                min: 0.0,
                max: 2.0,
                onChanged: controller.adjustContrast,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: value,
                min: min,
                max: max,
                onChanged: onChanged,
              ),
            ),
            Text(value.toStringAsFixed(1)),
          ],
        ),
      ],
    );
  }
} 