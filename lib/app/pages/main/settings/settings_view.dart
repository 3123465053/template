import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: [
          _buildSection(
            title: '通用设置',
            children: [
              Obx(() => SwitchListTile(
                title: Text('深色模式'),
                subtitle: Text('切换应用主题'),
                value: controller.isDarkMode.value,
                onChanged: (_) => controller.toggleDarkMode(),
              )),
              Obx(() => SwitchListTile(
                title: Text('自动保存'),
                subtitle: Text('自动保存识别结果'),
                value: controller.isAutoSave.value,
                onChanged: (_) => controller.toggleAutoSave(),
              )),
            ],
          ),
          _buildSection(
            title: '识别设置',
            children: [
              Obx(() => ListTile(
                title: Text('历史记录数量'),
                subtitle: Text('最多保存${controller.maxHistoryCount.value}条记录'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: controller.maxHistoryCount.value > 10
                          ? () => controller.updateMaxHistoryCount(controller.maxHistoryCount.value - 10)
                          : null,
                    ),
                    Text('${controller.maxHistoryCount.value}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: controller.maxHistoryCount.value < 100
                          ? () => controller.updateMaxHistoryCount(controller.maxHistoryCount.value + 10)
                          : null,
                    ),
                  ],
                ),
              )),
              Obx(() => ListTile(
                title: Text('图片质量'),
                subtitle: Text('${(controller.imageQuality.value * 100).toInt()}%'),
                trailing: Slider(
                  value: controller.imageQuality.value,
                  min: 0.5,
                  max: 1.0,
                  divisions: 5,
                  label: '${(controller.imageQuality.value * 100).toInt()}%',
                  onChanged: (value) => controller.updateImageQuality(value),
                ),
              )),
            ],
          ),
          _buildSection(
            title: '语言设置',
            children: [
              Obx(() => ListTile(
                title: Text('语言'),
                subtitle: Text(controller.language.value == 'zh_CN' ? '简体中文' : 'English'),
                trailing: DropdownButton<String>(
                  value: controller.language.value,
                  items: [
                    DropdownMenuItem(
                      value: 'zh_CN',
                      child: Text('简体中文'),
                    ),
                    DropdownMenuItem(
                      value: 'en_US',
                      child: Text('English'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateLanguage(value);
                    }
                  },
                ),
              )),
            ],
          ),
          _buildSection(
            title: '其他',
            children: [
              ListTile(
                title: Text('清除缓存'),
                subtitle: Text('清除应用缓存数据'),
                trailing: Icon(Icons.chevron_right),
                onTap: controller.clearCache,
              ),
              ListTile(
                title: Text('检查更新'),
                subtitle: Text('检查新版本'),
                trailing: Icon(Icons.chevron_right),
                onTap: controller.checkUpdate,
              ),
              ListTile(
                title: Text('关于'),
                subtitle: Text('查看应用信息'),
                trailing: Icon(Icons.chevron_right),
                onTap: controller.about,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        ...children,
        Divider(),
      ],
    );
  }
}