import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/colors.dart';
import '../../../models/notifications_model.dart';
import '../../core/constant/enums.dart';
import '../../core/widgets/tiles.dart';
import 'notification_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    super.key,
    required this.notificationText,
  });
  final String notificationText;

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(NotificationController());
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<NotificationController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 50),
                Wrap(
                  spacing: 5.0,
                  children: List<Widget>.generate(
                    notificationController.status.length,
                    (int index) {
                      return ChoiceChip(
                        showCheckmark: false,
                        label: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * .06,
                            vertical: 8,
                          ),
                          child: Text(
                              "${notificationController.status[index].status.capitalizeFirst}"),
                        ),
                        selected:
                            notificationController.notificationSelectedTab ==
                                notificationController.status[index].status,
                        selectedColor: AppColor.red,
                        labelStyle: notificationController
                                    .status[index].status ==
                                notificationController.notificationSelectedTab
                            ? const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              )
                            : const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                        onSelected: (bool selected) {
                          notificationController.notificationSelectedTab =
                              notificationController.status[index].status;
                          notificationController.update();
                        },
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: _notifications(
                  notificationController.notificationSelectedTab,
                )),
              ],
            );
          },
        ),
      ),
    );
  }

  StreamBuilder _notifications(String status) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(Collection.notifications.name)
          .where("status", isEqualTo: status)
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.size == 0) {
          return const Center(
            child: Text(
              "No Notifications!",
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
            ),
          );
        }
        final List<NotificationsModel> notifications = snapshot.data!.docs
            .map((doc) => NotificationsModel.fromMap(doc.data()))
            .toList();
        return ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            final notificationIndex = notifications[index];
            return CustomListTileWidget(
              title:
                  "${notificationIndex.firstName} ${notificationIndex.lastName} | ",
              imgurl: notificationIndex.imgUrl,
              subtitle: notificationIndex.email,
              role: "${notificationIndex.role.capitalize}",
              accpet: status != UserStatus.approved.name
                  ? () => NotificationController().accept(
                        UserData(
                            context: context,
                            notification: notifications[index],
                            status: status,
                            userEmail: notificationIndex.email,
                            userName:
                                "${notificationIndex.firstName} ${notificationIndex.lastName}"),
                      )
                  : null,
              reject: status != UserStatus.decline.name
                  ? () => NotificationController().reject(
                        UserData(
                            context: context,
                            notification: notifications[index],
                            status: status,
                            userEmail: notificationIndex.email,
                            userName:
                                "${notificationIndex.firstName} ${notificationIndex.lastName}"),
                      )
                  : null,
            );
          },
        );
      },
    );
  }
}

class UserData {
  final NotificationsModel notification;
  final String status;
  final BuildContext context;
  final String userName;
  final String userEmail;

  UserData({
    required this.notification,
    required this.status,
    required this.context,
    required this.userName,
    required this.userEmail,
  });
}
