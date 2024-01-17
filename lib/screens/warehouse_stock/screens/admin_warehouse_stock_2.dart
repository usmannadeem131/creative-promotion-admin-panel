import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/stocks_model.dart';
import '../../../../../core/utils/colors.dart';
import '../../../core/constant/enums.dart';
import '../../../core/utils/references.dart';
import '../controllers/admin_stocks_controller.dart';

class AdminWarehouseStockScreen2 extends StatelessWidget {
  const AdminWarehouseStockScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminWarehouseStockController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * .1),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppAssets.logo,
                  height: Get.height * .2,
                ),
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(Collection.stocks.name)
                    .where("createdBy", isEqualTo: controller.uid)
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.size == 0) {
                    return Container(
                      height: screenHeight,
                      padding: EdgeInsets.only(top: Get.height * .2),
                      child: const Text(
                        "No Stock Available!",
                        style: TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  final List<StockModel> stocksList = snapshot.data!.docs
                      .map((doc) => StockModel.fromMap(doc.data()))
                      .toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Available Stock: ",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.download,
                              size: 50,
                            ),
                            onPressed: () =>
                                controller.weeklyDownloadData(stocksList),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all(width: 2)),
                        child: DataTable(
                          horizontalMargin: screenWidth * .01,
                          columnSpacing: 8.0,
                          headingTextStyle: const TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          headingRowHeight: screenHeight * .1,
                          dataTextStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          dividerThickness: 2.0,
                          dataRowMaxHeight: screenHeight * .1,
                          headingRowColor:
                              MaterialStateColor.resolveWith((states) {
                            return AppColor.red;
                          }),
                          columns: const [
                            DataColumn(label: Text("Category")),
                            DataColumn(label: Text("Date and Time")),
                            DataColumn(label: Text("No of Pieces")),
                          ],
                          rows: stocksList.map((stock) {
                            DateTime formatedDate =
                                DateTime.fromMillisecondsSinceEpoch(
                                    stock.createdAt!.seconds * 1000);
                            return DataRow(
                              cells: [
                                DataCell(Text(stock.catagory ?? "")),
                                DataCell(Align(
                                  alignment: Alignment.center,
                                  child: Text(DateFormat("dd/MM/yyyy - h:m a")
                                      .format(formatedDate)),
                                )),
                                DataCell(Align(
                                  alignment: Alignment.center,
                                  child: Text("${stock.quantity}"),
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
