import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/supply_stock_model.dart';
import '../../../core/utils/functions.dart';

class SuppllyStockDetailScreen extends StatelessWidget {
  final SupplyModel data;
  const SuppllyStockDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * .07),
              Align(
                alignment: Alignment.center,
                child: Text(
                  data.agentName,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .05),
              Row(
                children: [
                  const Text(
                    "Store Information",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => singleSupplyStockDownload(data),
                    icon: const Icon(Icons.download, size: 50),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * .05),
              const Text(
                "Warehouse Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.warehouseName),
              const SizedBox(height: 15),
              const Text(
                "Agent Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.agentName),
              const SizedBox(height: 15),
              const Text(
                "Email Address",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.emailAddress),
              const SizedBox(height: 15),
              const Text(
                "Full Synthetic - OW-20",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.fullySyntyheticOW20),
              const SizedBox(height: 15),
              const Text(
                'Full Synthethic  - 5W-20',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.fullySyntyhetic5W20),
              const SizedBox(height: 15),
              const Text(
                'Full Synthethic  - 5W-30',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.fullySyntyhetic5W30),
              const SizedBox(height: 15),
              const Text(
                'High Mileage - OW-20',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.highMileageOW20),
              const SizedBox(height: 15),
              const Text(
                'High Mileage - 5W-20',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.highMileage5W20),
              const SizedBox(height: 15),
              const Text(
                'High Mileage - 5W-30',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.highMileage5W30),
              const SizedBox(height: 15),
              const Text(
                'Advance  - OW-20',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.advanceOW20),
              const SizedBox(height: 15),
              const Text(
                'Advance  - 5W-20',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.advance5W20),
              const SizedBox(height: 15),
              const Text(
                'Advance  - 5W-30',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(textValue: data.advance5W30),
              const SizedBox(height: 15),
              const Text(
                "Day and Date",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              OverviewValueWidget(
                textValue: DateFormat("dd/MM/yyyy-h:m a").format(
                  data.date.toDate(),
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    ));
  }
}

class OverviewValueWidget extends StatelessWidget {
  const OverviewValueWidget({
    super.key,
    required this.textValue,
  });

  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
        color: const Color.fromARGB(255, 239, 239, 239),
      ),
      height: 44,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            textValue,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
