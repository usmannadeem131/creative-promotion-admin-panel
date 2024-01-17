import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/colors.dart';
import '../controllers/manager_details_controller.dart';
import 'supply_stock_detail.dart';

class SupplyData extends StatelessWidget {
  const SupplyData({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MangerDetailsController());
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .1),
          child: Column(
            children: [
              SizedBox(height: screenHeight * .07),
              const Text(
                "Overview Data",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * .1),
              GetBuilder<MangerDetailsController>(builder: (_) {
                return controller.isFetchedData == false
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColor.red,
                        backgroundColor: Colors.black,
                      ))
                    : controller.selectedSupplyList.isEmpty
                        ? const Center(
                            child: Text(
                              "No Data!",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        : ListView.builder(
                            itemCount: controller.selectedSupplyList.length,
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(bottom: screenHeight * .04),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenHeight * .02),
                                    child: ListTile(
                                        title: Text(
                                          controller
                                              .selectedSupplyList[i].agentName,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              controller.selectedSupplyList[i]
                                                  .emailAddress,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                              overflow: TextOverflow.visible,
                                            )),
                                            Text(
                                              DateFormat("dd-MM-yyyy").format(
                                                controller.selectedSupplyList[i]
                                                    .createdAt
                                                    .toDate(),
                                              ),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        onTap: () => {
                                              Get.to(() =>
                                                  SuppllyStockDetailScreen(
                                                    data: controller
                                                        .selectedSupplyList[i],
                                                  )),
                                            }),
                                  ),
                                ),
                              );
                            },
                          );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
