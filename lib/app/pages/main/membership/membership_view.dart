import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'membership_controller.dart';

class MembershipView extends GetView<MembershipController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 会员权益展示
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              children: [
                Icon(
                  Icons.card_membership,
                  size: 40,
                  color: Colors.blue,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '开通会员享专属特权',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '解锁全部高级功能，享受更好的服务',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 会员套餐列表
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: controller.membershipPlans.length,
                itemBuilder: (context, index) {
                  final plan = controller.membershipPlans[index];
                  return Obx(
                    () => Card(
                      margin: EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () => controller.selectPlan(plan),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: controller.selectedPlan.value == plan
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    plan['name'].toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        '¥',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        plan['price'].toString(),
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        ' /${plan['duration']}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                '原价：¥${plan['originalPrice']}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 16),
                              ...List.generate(
                                (plan['features'] as List<String>).length,
                                (index) => Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text((plan['features'] as List<String>)[index]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // 购买按钮
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: controller.purchase,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  '立即开通',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 