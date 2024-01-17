import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/enums.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/others.dart';
import '../../../core/widgets/textfield.dart';
import '../controller/agent_controller.dart';
import '../controller/agent_details_controller.dart';

class AgentDetailScreen extends StatelessWidget {
  const AgentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgentDeailsController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AgentDeailsController>(
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
                      "Agent Details",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenHeight * .03),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        CircleImage(
                          heading:
                              "${controller.agentModel?.firstName} ${controller.agentModel?.lastName}",
                          imageUrl: controller.agentModel?.imgUrl,
                          size: screenHeight * .15,
                          fontSize: 26,
                        ),
                        SizedBox(width: screenWidth * .02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.agentModel?.firstName} ${controller.agentModel?.lastName}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${controller.agentModel?.email}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                            Text(
                              "${controller.agentModel?.phone}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * .05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AgentProgressDetailsWidget(
                          text: "Covered Stores",
                          widget: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection(Collection.storeData.name)
                                .where("addById",
                                    isEqualTo: controller.agentModel?.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Text(
                                "${snapshot.data?.docs.length ?? 0}",
                                style: const TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            },
                          ),
                        ),
                        AgentProgressDetailsWidget(
                          text: "Commision",
                          widget: Text(
                            "\$"
                            "${controller.agentModel?.commision}",
                            style: const TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        AgentProgressDetailsWidget(
                          text: "Total Earnings",
                          widget: Text(
                            "\$"
                            "${controller.agentModel?.totalCommision}",
                            style: const TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Select Dates:",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MaterialButton(
                                onPressed: () =>
                                    Get.put(AgentController()).changeComission(
                                  context,
                                  controller.agentModel?.uid ?? "",
                                  controller.agentModel?.commision ?? 0.0,
                                ),
                                color: Colors.blue,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Change commission",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              MaterialButton(
                                onPressed: () =>
                                    controller.agentModel?.status !=
                                            UserStatus.decline.name
                                        ? controller.restrictAgent(context,
                                            controller.agentModel?.uid ?? "")
                                        : controller.unRestrictAgent(context,
                                            controller.agentModel?.uid ?? ""),
                                color: controller.agentModel?.status !=
                                        UserStatus.decline.name
                                    ? Colors.red
                                    : Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      controller.agentModel?.status !=
                                              UserStatus.decline.name
                                          ? "Restricted user"
                                          : "Unrestricted user",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class AgentProgressDetailsWidget extends StatelessWidget {
  const AgentProgressDetailsWidget({
    super.key,
    required this.text,
    required this.widget,
  });

  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .16,
      width: MediaQuery.of(context).size.width * .16,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget,
          Text(
            text,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
