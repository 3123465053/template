import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../common/Widget/app_bar_ext.dart';
import '../../../common/config/app_color.dart';
import 'logic.dart';
class HomePage extends GetView<HomeLogic> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pageBackgroundColor,
      appBar: appBarExt("首页"),
      body: Center(
        child: Text("首页"),
      ),
    );
  }
}
