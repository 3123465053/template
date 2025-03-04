
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MePage extends GetView<MeLogic> {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("我的"),
      ),
    );
  }
}
