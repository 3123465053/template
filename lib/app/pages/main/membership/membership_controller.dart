import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembershipController extends GetxController {
  // 会员套餐列表
  final membershipPlans = [
    {
      'id': 'monthly',
      'name': '月度会员',
      'price': 29.9,
      'originalPrice': 39.9,
      'features': [
        '无限次识别',
        '高清图片存储',
        '优先识别处理',
        '专属客服支持',
      ],
      'duration': '30天',
    },
    {
      'id': 'yearly',
      'name': '年度会员',
      'price': 299.0,
      'originalPrice': 399.0,
      'features': [
        '无限次识别',
        '高清图片存储',
        '优先识别处理',
        '专属客服支持',
        '情侣专属功能',
        '额外2个月赠送',
      ],
      'duration': '365天',
    },
  ].obs;

  // 当前选中的套餐
  var selectedPlan = Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    super.onInit();
    // 默认选中月度会员
    selectedPlan.value = membershipPlans[0];
  }

  void selectPlan(Map<String, dynamic> plan) {
    selectedPlan.value = plan;
  }

  void purchase() {
    if (selectedPlan.value == null) {
      Get.snackbar('提示', '请选择会员套餐');
      return;
    }

    // TODO: 实现支付逻辑
    Get.dialog(
      AlertDialog(
        title: Text('确认购买'),
        content: Text('是否确认购买${selectedPlan.value!['name']}？\n价格：¥${selectedPlan.value!['price']}'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar('成功', '购买成功！');
              // TODO: 更新会员状态
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }
} 