import 'dart:io';

import 'package:creativepromotionweb/screens/dasboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/controllers/user_controller.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../../models/user_model.dart';

class AdminProfileController extends GetxController {
  final firstName = TextEditingController(text: Constant.user?.firstName);
  final lastName = TextEditingController(text: Constant.user?.lastName);
  File? profileRef;

  void updateProfile() async {
    UserModel? user = Constant.user?.copyWith(
      firstName: firstName.text,
      lastName: lastName.text,
    );
    Constant.user = user!;
    final isSuccess = await FirestoreService.updateProfile(user);
    if (!isSuccess) return;
    final controller = Get.put(UserController());
    controller.updateUserState(user);
    Get.off(() => const DashboardScreen());
  }
}
