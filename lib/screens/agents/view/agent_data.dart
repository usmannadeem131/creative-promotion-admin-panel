import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/colors.dart';
import '../controller/agent_details_controller.dart';
import 'store_detail_screen.dart';

class AgentDataScreen extends StatelessWidget {
  const AgentDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgentDeailsController());
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
              GetBuilder<AgentDeailsController>(builder: (_) {
                return controller.isFetchedData == false
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColor.red,
                        backgroundColor: Colors.black,
                      ))
                    : controller.selectedStores.isEmpty
                        ? const Center(
                            child: Text(
                              "No Data!",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        : ListView.builder(
                            itemCount: controller.selectedStores.length,
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
                                              .selectedStores[i].storeName,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Text(
                                          controller
                                              .selectedStores[i].storeEmail,
                                          style: const TextStyle(fontSize: 16),
                                          overflow: TextOverflow.visible,
                                        ),
                                        onTap: () => {
                                              Get.to(
                                                () => StoreDetailScreen(
                                                  store: controller
                                                      .selectedStores[i],
                                                ),
                                                routeName: '/storeinformation',
                                              ),
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
