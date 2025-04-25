import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 用户信息卡片
            Obx(() => _buildUserInfoCard()),
            SizedBox(height: 16),
            // 使用统计卡片
            Obx(() => _buildStatisticsCard()),
            SizedBox(height: 16),
            // 功能列表
            _buildFunctionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(controller.userInfo['avatar']!),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userInfo['nickname']!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '性别：${controller.userInfo['gender']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        '生日：${controller.userInfo['birthday']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: controller.editProfile,
                ),
              ],
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: controller.bindPartner,
              child: Text(
                controller.userInfo['partnerAccount']!.isEmpty
                    ? '绑定情侣账号'
                    : '已绑定：${controller.userInfo['partnerAccount']}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '使用统计',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  '总识别次数',
                  '${controller.statistics['totalRecognitions']}',
                ),
                _buildStatItem(
                  '本月识别',
                  '${controller.statistics['thisMonthRecognitions']}',
                ),
                _buildStatItem(
                  '平均准确率',
                  '${(controller.statistics['accuracy']??0 * 100).toStringAsFixed(1)}%',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFunctionList() {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.card_membership),
            title: Text('会员中心'),
            trailing: Icon(Icons.chevron_right),
            onTap: controller.viewMembershipInfo,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('分享应用'),
            trailing: Icon(Icons.chevron_right),
            onTap: controller.shareApp,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('联系客服'),
            trailing: Icon(Icons.chevron_right),
            onTap: controller.contactSupport,
          ),
        ],
      ),
    );
  }
} 