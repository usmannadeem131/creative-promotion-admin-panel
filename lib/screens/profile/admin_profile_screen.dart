import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/others.dart';
import '../../../../core/widgets/textfield.dart';
import 'admin_profile_controller.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminProfileController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .3),
        child: Column(
          children: [
            SizedBox(height: screenHeight * .2),
            const SizedBox(height: 20),
            GetBuilder<AdminProfileController>(
              init: AdminProfileController(),
              builder: (_) => GestureDetector(
                child: CircleImage(
                  heading:
                      "${Constant.user!.firstName} ${Constant.user!.lastName}",
                  size: 100,
                  fontSize: 26,
                  isEditScreen: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(Constant.user!.email),
            const SizedBox(height: 15),
            TextFieldWidget(
              controller: controller.firstName,
              hintText: "First Name",
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              controller: controller.lastName,
              hintText: "Last Name",
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: Get.width,
              child: AppButton(
                onTap: () => controller.updateProfile(),
                title: "Update",
                color: AppColor.red,
                titleStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
