import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../core/widgets/cards.dart';
import '../../../../../core/widgets/textfield.dart';
import '../../../../../models/user_model.dart';
import '../controllers/warehouse_manager_controller.dart';

class WarehouseManagerScreen extends StatelessWidget {
  const WarehouseManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WarehouseManagerController());
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              "Warehouse Manager",
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
                    .where("role", isEqualTo: Role.manager.name)
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
                  controller.totalManagers = [];
                  controller.filterManagers = [];
                  controller.totalManagers = snapshot.data!.docs
                      .map((doc) => UserModel.fromMap(doc.data()))
                      .toList();

                  controller.filterManagers.addAll(controller.totalManagers);

                  return GetBuilder<WarehouseManagerController>(
                    builder: (_) {
                      return GridView.builder(
                          itemCount: controller.filterManagers.length,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisExtent: 240,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final manager = controller.filterManagers;
                            return AgentsCardWidget(
                                imgUrl: manager[index].imgUrl,
                                name:
                                    "${manager[index].firstName} ${manager[index].lastName}",
                                email: manager[index].email,
                                showIcon: manager[index].status ==
                                    UserStatus.decline.name,
                                onTap: () {
                                  Get.toNamed("/managerdetails", arguments: {
                                    "managerModel": manager[index],
                                  });
                                });
                          });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
