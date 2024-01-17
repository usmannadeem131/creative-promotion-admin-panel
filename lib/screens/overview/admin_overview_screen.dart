import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotionweb/core/utils/functions.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/enums.dart';
import '../../../core/utils/colors.dart';
import '../../../models/store_model.dart';

class AdminOverviewScreen extends StatelessWidget {
  const AdminOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              "Overview",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * .025),
            Container(
              height: screenHeight * .15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.red,
                  width: 5,
                ),
              ),
              child: Center(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection(Collection.users.name)
                        .where("role", isEqualTo: Role.agent.name)
                        .where("status", isEqualTo: UserStatus.approved.name)
                        .snapshots(),
                    builder: (context, snapshot) {
                      final length = snapshot.data?.docs.length ?? 0;

                      return Center(
                        child: Text(
                          length.formatter(),
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(height: screenHeight * .01),
            const Text(
              "Total Agents",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * .025),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection(Collection.storeData.name)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.size == 0) {
                  return const OverViewCards(
                    title: "Total Cost",
                    text: "\$0",
                  );
                }
                double totalcost = 0.0;
                for (var element in (snapshot.data!.docs
                    .map((doc) => StoreModel.fromMap(doc.data()))
                    .toList())) {
                  totalcost += element.comission;
                }
                return OverViewCards(
                  title: "Total Cost",
                  text: "\$" "$totalcost",
                );
              },
            ),
            SizedBox(height: screenHeight * .025),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(Collection.users.name)
                    .where("role", isEqualTo: "manager")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.size == 0) {
                    return const OverViewCards(
                      title: "Total Warehouse",
                      text: "0",
                    );
                  }
                  return OverViewCards(
                    title: "Total Warehouse",
                    text: "${snapshot.data!.docs.length}",
                  );
                }),
            SizedBox(height: screenHeight * .025),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(Collection.storeData.name)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.size == 0) {
                    return const OverViewCards(
                      title: "Total Stores Coverd",
                      text: "0",
                    );
                  }
                  return OverViewCards(
                    title: "Total Stores Covered",
                    text: "${snapshot.data!.docs.length}",
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class OverViewCards extends StatelessWidget {
  final String title;
  final String text;
  const OverViewCards({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2),
            ),
            width: double.infinity,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
