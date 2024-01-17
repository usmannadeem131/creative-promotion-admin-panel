import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/enums.dart';
import '../../../core/widgets/cards.dart';
import '../../../core/widgets/textfield.dart';
import '../../../models/user_model.dart';
import '../controller/agent_controller.dart';

class AgentsScreenWidget extends StatelessWidget {
  const AgentsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgentController());
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .016),
          child: Column(
            children: [
              const Text(
                "Agents",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * .05),
              SearchTextFieldWidget(
                controller: controller.search,
                onChanged: controller.onSearch,
                hintText: "Search",
              ),
              SizedBox(height: screenHeight * .03),
              SizedBox(
                height: screenHeight * .6,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection(Collection.users.name)
                      .where("role", isEqualTo: "agent")
                      .orderBy("createdAt", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.size == 0) {
                      return const Center(
                        child: Text(
                          "No data Available!",
                          style: TextStyle(
                              fontSize: 35.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    controller.totalAgents = [];
                    controller.filterAgents = [];
                    controller.totalAgents = snapshot.data!.docs
                        .map((doc) => UserModel.fromMap(doc.data()))
                        .toList();
                    controller.filterAgents.addAll(controller.totalAgents);
                    return GetBuilder<AgentController>(
                      builder: (_) {
                        return GridView.builder(
                            itemCount: controller.filterAgents.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisExtent: 240,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              final agents = controller.filterAgents;
                              return AgentsCardWidget(
                                  imgUrl: agents[index].imgUrl,
                                  name:
                                      "${agents[index].firstName} ${agents[index].lastName}",
                                  email: agents[index].email,
                                  showIcon: agents[index].status ==
                                      UserStatus.decline.name,
                                  onTap: () => Get.toNamed(
                                        '/agentdetails',
                                        arguments: {
                                          "userModel": agents[index],
                                        },
                                      )

                                  // Get.to(
                                  //     () => const AgentDetailScreen(),
                                  //     arguments: {
                                  //       "userModel": agents[index],
                                  //     }),
                                  );
                            });
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
