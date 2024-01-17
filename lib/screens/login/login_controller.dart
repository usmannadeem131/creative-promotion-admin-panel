import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/constant.dart';
import '../../core/constant/enums.dart';
import '../../core/services/firebase/firebase_auth.dart';
import '../../core/services/firebase/firestore_service.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscurePassword = false;
  bool isChecked = false;

  void login() async {
    if (isChecked == false) {
      showOkAlertDialog(
        context: Get.context!,
        title: "Error",
        message: "Please Check mark Terms and Consitios and Privacy Policy",
      );
      return;
    }
    try {
      final userCredential = await SignInService()
          .signInWithEmailAndPassword(email.text, password.text);
      // final userCredential = await SignInService().signInWithEmailAndPassword(
      //     "thecreativepromotioncompany@gmail.com", "FaizMak131@");

      if (userCredential != null) {
        Constant.user =
            await FirestoreService.getCurrentUser(userCredential.user!.uid);
        if (Constant.user!.role == Role.admin.name) {
          Get.offAllNamed('/dasboard');
          // Get.offAll(
          //   () => const admin.DashboardScreen(),
          //   routeName: "/dashboard",
          // );
        }
        return;
      }
    } catch (error) {
      return;
    }
  }

  void signinpasswordstatus() {
    obscurePassword = !obscurePassword;
    update();
  }
}
