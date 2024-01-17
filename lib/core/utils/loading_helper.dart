import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class LoadingHelper {
  static showLoading() {
    Get.dialog(
      const Center(
        child: SizedBox(
          height: 70,
          width: 70,
          child: CircularProgressIndicator(
            color: AppColor.red,
            backgroundColor: Colors.white,
            strokeWidth: 8.0,
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  static hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
