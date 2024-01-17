import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../core/widgets/others.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/textfield.dart';
import '../controllers/manager_details_controller.dart';

class WarehouseManagerDetail extends StatelessWidget {
  const WarehouseManagerDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MangerDetailsController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<MangerDetailsController>(
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * .22),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * .07),
                  const Text(
                    "Manager Details",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: screenHeight * .03),
                  Align(
                    alignment: Alignment.center,
                    child: CircleImage(
                      heading:
                          "${controller.managerModel?.firstName} ${controller.managerModel?.lastName}",
                      imageUrl: controller.managerModel?.imgUrl,
                      size: screenHeight * .15,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(height: screenHeight * .02),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${controller.managerModel?.firstName} ${controller.managerModel?.lastName}",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * .03),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RichTextWidget(
                                  title: "Email: ",
                                  text: "${controller.managerModel?.email}"),
                              const SizedBox(height: 10),
                              RichTextWidget(
                                  title: "Phone: ",
                                  text: "${controller.managerModel?.phone}"),
                              const SizedBox(height: 10),
                              RichTextWidget(
                                  title: "Warehouse Name: ",
                                  text:
                                      "${controller.managerModel?.manager!.name}"),
                              const SizedBox(height: 10),
                              RichTextWidget(
                                  title: "Warehouse Number: ",
                                  text:
                                      "${controller.managerModel?.manager!.number}"),
                              const SizedBox(height: 10),
                              RichTextWidget(
                                  title: "Warehouse Address: ",
                                  text:
                                      "${controller.managerModel?.manager!.address}"),
                              const SizedBox(height: 10),
                              RichTextWidget(
                                  title: "Warehouse State: ",
                                  text:
                                      "${controller.managerModel?.manager!.state}"),
                              const SizedBox(height: 10),
                              RichTextWidget(
                                  title: "Warehouse Size: ",
                                  text:
                                      "${controller.managerModel?.manager!.size} sq ft"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Select Dates:",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: screenWidth * .07),
                      SizedBox(
                        width: screenWidth * .2,
                        child: TextFieldWidget(
                          controller: TextEditingController(
                              text: controller.firstDateText),
                          onTap: () => controller.firstDateMethod(context),
                        ),
                      ),
                      const Text("To",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: screenWidth * .2,
                        child: TextFieldWidget(
                          controller: TextEditingController(
                              text: controller.secondDateText),
                          onTap: () => controller.secondDateMethod(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: screenWidth * .2,
                      child: AppButton(
                        title: "Search ",
                        onTap: controller.isFirstSelect &&
                                controller.isSecondSelect
                            ? () {
                                controller.onSearchFunction();
                              }
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Actions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: MaterialButton(
                        onPressed: () => controller.managerModel?.status !=
                                UserStatus.decline.name
                            ? controller.restrictAgent(
                                context, controller.managerModel?.uid ?? "")
                            : controller.unRestrictAgent(
                                context, controller.managerModel?.uid ?? ""),
                        color: controller.managerModel?.status !=
                                UserStatus.decline.name
                            ? Colors.red
                            : Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              controller.managerModel?.status !=
                                      UserStatus.decline.name
                                  ? "Restricted user"
                                  : "Unrestricted user",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.title,
    required this.text,
  });
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: text,
          style: const TextStyle(fontSize: 20),
        )
      ]),
      textAlign: TextAlign.start,
    );
  }
}
