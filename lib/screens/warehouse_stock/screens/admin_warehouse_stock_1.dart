import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/cards.dart';
import '../../../core/constant/enums.dart';
import '../../../models/user_model.dart';
import '../controllers/admin_stocks_controller.dart';

class AdminWarehouseStocksScreen1 extends StatelessWidget {
  const AdminWarehouseStocksScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminWarehouseStockController());
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Warehouse Stock",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * .1),
            SizedBox(
              height: screenHeight * .65,
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
                          "No Stock Overview Available!",
                          style: TextStyle(
                              fontSize: 35.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    final List<UserModel> managers = snapshot.data!.docs
                        .map((doc) => UserModel.fromMap(doc.data()))
                        .toList();
                    controller.uid = managers.first.uid;

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: managers.length,
                      itemBuilder: (_, index) =>
                          GetBuilder<AdminWarehouseStockController>(
                        builder: (_) {
                          final manager = managers[index];
                          return StockCardWidget(
                            onTap: () {
                              controller.onTap(manager.uid);
                            },
                            title: manager.manager!.name,
                            isSelected: controller.uid == manager.uid,
                          );
                        },
                      ),
                      separatorBuilder: (_, i) => const SizedBox(height: 20),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
