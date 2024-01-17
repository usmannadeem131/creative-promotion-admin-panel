import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotionweb/models/store_notification_model.dart';
import 'package:creativepromotionweb/screens/profile/admin_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/utils/colors.dart';
import '../../core/controllers/user_controller.dart';
import '../../core/utils/functions.dart';
import '../../core/utils/references.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/custom_widget.dart';
import '../../core/widgets/textfield.dart';
import '../../core/widgets/tiles.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (_) {
          return Row(
            children: [
              //Dashboard Menu Section
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.red,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * .05),
                      const Image(
                        image: AssetImage(AppAssets.whiteBackground),
                      ),
                      const SizedBox(),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(9)),
                        ),
                      ),
                      SizedBox(height: screenHeight * .04),
                      TapTileWidget(
                        title: "Home",
                        iconRef: AppAssets.home,
                        iconColor: controller.selectedWidgetIndex == 0
                            ? Colors.black
                            : Colors.white,
                        textColor: controller.selectedWidgetIndex == 0
                            ? Colors.black
                            : Colors.white,
                        backgroundColor: controller.selectedWidgetIndex == 0
                            ? Colors.white
                            : AppColor.red,
                        onTap: () {
                          controller.selectedWidgetIndex = 0;
                          controller.update();
                          controller.updateWidget();
                        },
                      ),
                      TapTileWidget(
                        title: "Agents",
                        iconRef: AppAssets.overview,
                        iconColor: controller.selectedWidgetIndex == 1
                            ? Colors.black
                            : Colors.white,
                        textColor: controller.selectedWidgetIndex == 1
                            ? Colors.black
                            : Colors.white,
                        backgroundColor: controller.selectedWidgetIndex == 1
                            ? Colors.white
                            : AppColor.red,
                        onTap: () {
                          controller.selectedWidgetIndex = 1;
                          controller.update();
                          controller.updateWidget();
                        },
                      ),
                      TapTileWidget(
                        iconRef: AppAssets.agent,
                        title: "Overview",
                        iconColor: controller.selectedWidgetIndex == 2
                            ? Colors.black
                            : Colors.white,
                        textColor: controller.selectedWidgetIndex == 2
                            ? Colors.black
                            : Colors.white,
                        backgroundColor: controller.selectedWidgetIndex == 2
                            ? Colors.white
                            : AppColor.red,
                        onTap: () {
                          controller.selectedWidgetIndex = 2;
                          controller.update();
                          controller.updateWidget();
                        },
                      ),
                      TapTileWidget(
                        iconRef: AppAssets.notification,
                        title: "Notifications",
                        iconColor: controller.selectedWidgetIndex == 3
                            ? Colors.black
                            : Colors.white,
                        textColor: controller.selectedWidgetIndex == 3
                            ? Colors.black
                            : Colors.white,
                        backgroundColor: controller.selectedWidgetIndex == 3
                            ? Colors.white
                            : AppColor.red,
                        onTap: () {
                          controller.selectedWidgetIndex = 3;
                          controller.update();
                          controller.updateWidget();
                        },
                      ),
                      TapTileWidget(
                        iconRef: AppAssets.manager,
                        title: "Warehouse Managers",
                        iconColor: controller.selectedWidgetIndex == 4
                            ? Colors.black
                            : Colors.white,
                        textColor: controller.selectedWidgetIndex == 4
                            ? Colors.black
                            : Colors.white,
                        backgroundColor: controller.selectedWidgetIndex == 4
                            ? Colors.white
                            : AppColor.red,
                        onTap: () {
                          controller.selectedWidgetIndex = 4;
                          controller.update();
                          controller.updateWidget();
                        },
                      ),
                      TapTileWidget(
                        iconRef: AppAssets.warehouse,
                        title: "Warehouse Stock",
                        iconColor: controller.selectedWidgetIndex == 5
                            ? Colors.black
                            : Colors.white,
                        textColor: controller.selectedWidgetIndex == 5
                            ? Colors.black
                            : Colors.white,
                        backgroundColor: controller.selectedWidgetIndex == 5
                            ? Colors.white
                            : AppColor.red,
                        onTap: () {
                          controller.selectedWidgetIndex = 5;
                          controller.update();
                          controller.updateWidget();
                        },
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        child: AppButton(
                          title: "Logout",
                          color: Colors.white,
                          titleStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          onTap: () => controller.logout(context),
                        ),
                      ),
                      SizedBox(height: screenHeight * .05)
                    ],
                  ),
                ),
              ),

              //Dashboard Screen Section
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(
                    left: screenWidth * .04,
                    right: screenWidth * .04,
                    top: screenHeight * .1,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dashboardCorner),
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                  child: controller.selectedWidget,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DashboardScreenWidget extends StatelessWidget {
  const DashboardScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dbcontroller = Get.put(DashboardController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (_) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  dbcontroller.isNotification = false;
                  dbcontroller.isOnAgentTap = false;
                  dbcontroller.update();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Welcome Admin",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),

                          // Notification Icon
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("storeNotification")
                                .orderBy("createdAt", descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData ||
                                  snapshot.data!.size == 0) {
                                return const Icon(
                                  Icons.notifications,
                                  size: 40,
                                  color: Colors.black,
                                );
                              }

                              List<StoreNotificationModel> notificationsList =
                                  snapshot.data!.docs
                                      .map((doc) =>
                                          StoreNotificationModel.fromMap(
                                              doc.data()))
                                      .toList();
                              for (var index = 0;
                                  index < notificationsList.length;
                                  index++) {
                                if (notificationsList[index].notificationView ==
                                    false) {
                                  if (!dbcontroller.unreadIdList.contains(
                                      "${notificationsList[index].notificationId}")) {
                                    dbcontroller.unreadIdList.add(
                                        "${notificationsList[index].notificationId}");
                                    dbcontroller.unreadNotificationsList
                                        .add(notificationsList[index]);
                                  }
                                }
                              }

                              return InkWell(
                                onTap: () {
                                  dbcontroller.isNotification =
                                      !dbcontroller.isNotification;
                                  dbcontroller.update();
                                },
                                child: Stack(
                                  children: [
                                    const Icon(
                                      Icons.notifications,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    dbcontroller.unreadNotificationsList.isEmpty
                                        ? const Offstage()
                                        : const Positioned(
                                            right: 5,
                                            bottom: 26,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 5,
                                              child: CircleAvatar(
                                                backgroundColor: AppColor.red,
                                                radius: 4,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            },
                          ),

                          //Admin Profile Picture
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const AdminProfileScreen(),
                                routeName: "/profile",
                              );
                            },
                            child: Stack(
                              children: [
                                GetBuilder<UserController>(
                                  init: UserController(),
                                  builder: (_) {
                                    return SizedBox(
                                      height: 48,
                                      width: 48,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Constant.user!.imgUrl.isNotEmpty
                                            ? Image.network(
                                                Constant.user!.imgUrl,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                decoration: const BoxDecoration(
                                                    color: AppColor.red),
                                                child: Center(
                                                  child: Text(
                                                    getInitialCharacters(
                                                      "${Constant.user!.firstName} ${Constant.user!.lastName}",
                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                                const Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 7,
                                    child: CircleAvatar(
                                      backgroundColor: AppColor.green,
                                      radius: 5,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    SizedBox(height: screenHeight * .04),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dbcontroller.dashboards,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Store Assign:",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Last Uploading: ${DateFormat("EEE, dd/MM/yyyy - h:m a").format(dbcontroller.recentExcelFileTime)}",
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 30),
                        InkWell(
                          onTap: () {
                            dbcontroller.isOnAgentTap =
                                !dbcontroller.isOnAgentTap;
                            dbcontroller.update();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              dbcontroller.selectedAgent,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color:
                                    dbcontroller.selectedAgent == "Select Agent"
                                        ? Colors.grey
                                        : Colors.black,
                              ),
                            ),
                            // DropdownButton(
                            //   underline: const Offstage(),
                            //   isExpanded: true,
                            //   icon: const Offstage(),
                            //   value: dbcontroller.selectedAgent,
                            //   onChanged: (value) {
                            //     dbcontroller.selectedAgent = value ?? '';
                            //     dbcontroller.update();
                            //   },
                            //   iconSize: 24,
                            //   elevation: 16,
                            //   items: dbcontroller.agentsList
                            //       .map<DropdownMenuItem<String>>((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Align(
                            //         alignment: AlignmentDirectional.centerStart,
                            //         child: Text(
                            //           value,
                            //           style: TextStyle(
                            //             fontSize: 18,
                            //             fontWeight: FontWeight.w500,
                            //             color: dbcontroller.selectedAgent ==
                            //                     "Select Agent"
                            //                 ? Colors.grey
                            //                 : Colors.black,
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   }).toList(),
                            // ),
                          ),
                        ),
                        InkWell(
                          onTap: () => dbcontroller.filePickerMethod(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              "Upload Excel File",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * .1,
                          child: TextFieldWidget(
                            hintText: "Assigning Date",
                            controller: TextEditingController(
                                text: dbcontroller.firstDateText),
                            onTap: () => dbcontroller.firstDateMethod(context),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * .1,
                          child: TextFieldWidget(
                            hintText: "End Date",
                            controller: TextEditingController(
                                text: dbcontroller.secondDateText),
                            onTap: () => dbcontroller.secondDateMethod(context),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: screenWidth * .1,
                            child: AppButton(
                              title: "Assign ",
                              onTap: () => dbcontroller.askSaveButtonDialog(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.red,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => dbcontroller.changeTab("pending"),
                          child: Text(
                            "Pending",
                            style: dbcontroller.notificationSelectedTab ==
                                    "pending"
                                ? const TextStyle(fontWeight: FontWeight.bold)
                                : TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.3)),
                          ),
                        ),
                        const SizedBox(width: 25),
                        GestureDetector(
                          onTap: () => dbcontroller.changeTab("approved"),
                          child: Text(
                            "Approval",
                            style: dbcontroller.notificationSelectedTab ==
                                    "approved"
                                ? const TextStyle(fontWeight: FontWeight.bold)
                                : TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.3)),
                          ),
                        ),
                        const SizedBox(width: 25),
                        GestureDetector(
                          onTap: () => dbcontroller.changeTab("decline"),
                          child: Text(
                            "Decline",
                            style: dbcontroller.notificationSelectedTab ==
                                    "decline"
                                ? const TextStyle(fontWeight: FontWeight.bold)
                                : TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.3)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: screenWidth * .4,
                      child: const Divider(),
                    ),
                    Expanded(
                        child: dbcontroller.notifications(
                            dbcontroller.notificationSelectedTab)),
                    const SizedBox(height: 12),
                    CustomButtonWidget(
                      onTap: () {
                        dbcontroller.selectedWidgetIndex = 3;
                        dbcontroller.update();
                        dbcontroller.updateWidget();
                      },
                      title: "see more",
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.1,
                          vertical: Get.height * 0.01),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Visibility(
                visible: dbcontroller.isNotification,
                child: Positioned(
                  top: 58,
                  right: 10,
                  child: Container(
                    width: screenWidth * .25,
                    height: screenHeight * .8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 3.0, //extend the shadow
                          offset: Offset(
                            3.0, // Move to right 5  horizontally
                            3.0, // Move to bottom 5 Vertically
                          ),
                        ),
                      ],
                    ),
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("storeNotification")
                            .orderBy("createdAt", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data!.size == 0) {
                            return const Center(
                              child: Text(
                                "No data Available!",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            );
                          }

                          dbcontroller.storeNotificationsList = snapshot
                              .data!.docs
                              .map((doc) =>
                                  StoreNotificationModel.fromMap(doc.data()))
                              .toList();

                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Text(
                                  "Notifications",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    NotificationSelectWidget(
                                      title: "All",
                                      boxColor:
                                          dbcontroller.notificationIndex == 0
                                              ? AppColor.red
                                              : AppColor.lightGrey,
                                      textColor:
                                          dbcontroller.notificationIndex == 0
                                              ? Colors.white
                                              : Colors.black,
                                      onTap: () {
                                        dbcontroller.notificationIndex = 0;
                                        dbcontroller.update();
                                      },
                                    ),
                                    NotificationSelectWidget(
                                      title: "Unread",
                                      boxColor:
                                          dbcontroller.notificationIndex == 1
                                              ? AppColor.red
                                              : AppColor.lightGrey,
                                      textColor:
                                          dbcontroller.notificationIndex == 1
                                              ? Colors.white
                                              : Colors.black,
                                      onTap: () {
                                        dbcontroller.notificationIndex = 1;
                                        dbcontroller.update();
                                      },
                                    ),
                                    const Spacer(),
                                    NotificationSelectWidget(
                                      title: "Clear All",
                                      boxColor: AppColor.red,
                                      textColor: Colors.white,
                                      onTap: () => dbcontroller
                                          .clearAllNotifications(dbcontroller
                                              .storeNotificationsList),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: SizedBox(
                                      child: dbcontroller.notificationIndex == 0
                                          // All Notifications List
                                          ? ListView.builder(
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: dbcontroller
                                                  .storeNotificationsList
                                                  .length,
                                              itemBuilder: (newContext, i) {
                                                return NotificationStatusWidget(
                                                  agentName: dbcontroller
                                                          .storeNotificationsList[
                                                              i]
                                                          .agentName ??
                                                      "",
                                                  storeName: dbcontroller
                                                          .storeNotificationsList[
                                                              i]
                                                          .storeName ??
                                                      "",
                                                  visitdate: "1 day ago",
                                                  isStoreDecline: dbcontroller
                                                      .storeNotificationsList[i]
                                                      .isDecline,
                                                  isViewed: dbcontroller
                                                      .storeNotificationsList[i]
                                                      .notificationView,
                                                  onTap: () => dbcontroller
                                                      .storeNotificationMethod(
                                                    dbcontroller
                                                        .storeNotificationsList[i],
                                                  ),
                                                  onTapDelete: () => dbcontroller
                                                      .clearNotification(
                                                          dbcontroller
                                                              .storeNotificationsList[i]),
                                                );
                                              })

                                          // Unread Notifications List
                                          : ListView.builder(
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: dbcontroller
                                                  .unreadNotificationsList
                                                  .length,
                                              itemBuilder: (context, i) {
                                                return NotificationStatusWidget(
                                                  agentName: dbcontroller
                                                          .unreadNotificationsList[
                                                              i]
                                                          .agentName ??
                                                      "",
                                                  storeName: dbcontroller
                                                          .unreadNotificationsList[
                                                              i]
                                                          .storeName ??
                                                      "",
                                                  visitdate: "1 day ago",
                                                  isStoreDecline: dbcontroller
                                                      .unreadNotificationsList[
                                                          i]
                                                      .isDecline,
                                                  isViewed: dbcontroller
                                                      .unreadNotificationsList[
                                                          i]
                                                      .notificationView,
                                                  onTap: () => dbcontroller
                                                      .storeNotificationMethod(
                                                    dbcontroller
                                                        .unreadNotificationsList[i],
                                                  ),
                                                );
                                              })),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
              Visibility(
                visible: dbcontroller.isOnAgentTap,
                child: Positioned(
                  left: 110,
                  top: 470,
                  child: Container(
                    width: screenWidth * .1,
                    height: screenHeight * .35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 3.0, //extend the shadow
                          offset: Offset(
                            3.0, // Move to right 5  horizontally
                            3.0, // Move to bottom 5 Vertically
                          ),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: dbcontroller.agentsList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            dbcontroller.selectedAgent =
                                dbcontroller.agentsList[i];
                            dbcontroller.isOnAgentTap =
                                !dbcontroller.isOnAgentTap;
                            dbcontroller.update();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 5, top: 5, bottom: 5),
                            child: Text(
                              dbcontroller.agentsList[i],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NotificationStatusWidget extends StatelessWidget {
  const NotificationStatusWidget({
    super.key,
    required this.agentName,
    required this.storeName,
    this.isStoreDecline = false,
    this.isViewed = false,
    required this.visitdate,
    this.onTap,
    this.onTapDelete,
  });
  final String agentName, storeName;
  final bool? isStoreDecline, isViewed;
  final String visitdate;
  final Function()? onTap;
  final Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Constant.user!.imgUrl.isNotEmpty
                    ? Image.network(
                        Constant.user!.imgUrl,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.person,
                        size: 50,
                      ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: agentName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isViewed == true ? Colors.grey : Colors.black,
                      ),
                      children: [
                        isStoreDecline == false
                            ? const TextSpan(
                                text: " has visited a store, that named was ",
                                style: TextStyle(fontWeight: FontWeight.w100),
                              )
                            : const TextSpan(
                                text:
                                    " has declined a store, with a reason that named was  ",
                                style: TextStyle(fontWeight: FontWeight.w100),
                              ),
                        TextSpan(
                          text: storeName,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: ".",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    visitdate,
                    style: TextStyle(
                      color: isViewed == true ? Colors.grey : AppColor.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            isViewed == true
                ? InkWell(
                    onTap: onTapDelete,
                    child: const Icon(
                      Icons.delete_forever_outlined,
                      size: 30,
                      color: Colors.red,
                    ),
                  )
                : Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: AppColor.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class NotificationSelectWidget extends StatelessWidget {
  const NotificationSelectWidget({
    super.key,
    required this.title,
    this.onTap,
    this.boxColor,
    this.textColor,
  });
  final String title;
  final Function()? onTap;
  final Color? boxColor, textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
