import 'package:flutter/material.dart';

import '../../models/store_notification_model.dart';

class DeclineNotificationScreen extends StatelessWidget {
  const DeclineNotificationScreen(
      {super.key, required this.storeNotificationModel});
  final StoreNotificationModel storeNotificationModel;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * .13),
            const Text(
              "Decline Reason",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * .02),
            Text(
              "${storeNotificationModel.declineReason}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
