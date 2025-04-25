import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // 用户信息
  final userInfo = {
    'avatar': 'https://picsum.photos/200',
    'nickname': '用户123456',
    'gender': '男',
    'birthday': '1990-01-01',
    'partnerAccount': '',  // 情侣账号
  }.obs;

  // 使用统计
  final statistics = {
    'totalRecognitions': 56,
    'thisMonthRecognitions': 12,
    'accuracy': 0.95,
  }.obs;

  void editProfile() {
    Get.toNamed('/profile/edit');
  }

  void bindPartner() {
    Get.dialog(
      AlertDialog(
        title: Text('绑定情侣账号'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: '请输入对方账号',
                hintText: '输入对方的用户ID',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              // 这里添加绑定逻辑
              Get.back();
              Get.snackbar('成功', '绑定请求已发送');
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }

  void viewMembershipInfo() {
    Get.toNamed('/membership');
  }

  void shareApp() {
    Get.snackbar('分享', '分享功能即将开放');
  }

  void contactSupport() {
    Get.snackbar('客服', '正在连接客服...');
  }
} 