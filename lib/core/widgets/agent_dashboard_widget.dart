import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/store_model.dart';
import '../constant/enums.dart';
import '../utils/references.dart';

class AgentDashboardWidget extends StatelessWidget {
  final String dashboardDescription;
  final String quantity;
  final String dashboardTitle;
  final bool totalCostEnable;
  const AgentDashboardWidget({
    super.key,
    required this.dashboardDescription,
    required this.dashboardTitle,
    required this.quantity,
    this.totalCostEnable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .3,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dashboardTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SvgPicture.asset(AppAssets.logoSvg),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text(
                  dashboardDescription,
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Text(
                  quantity,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Visibility(
            visible: totalCostEnable,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Text(
                    "Total cost spend",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection(Collection.storeData.name)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.size == 0) {
                          return const Text(
                            "\$0",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          );
                        }
                        double totalcost = 0.0;
                        for (var element in (snapshot.data!.docs
                            .map((doc) => StoreModel.fromMap(doc.data()))
                            .toList())) {
                          totalcost += element.comission;
                        }
                        return Text(
                          "\$" "$totalcost",
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        );
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
