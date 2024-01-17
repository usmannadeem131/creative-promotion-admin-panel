import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotionweb/screens/storenotification/decline_notification.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/enums.dart';
import '../../core/constant/constant.dart';
import '../../core/services/firebase/firebase_auth.dart';
import '../../core/utils/loading_helper.dart';
import '../../core/widgets/agent_dashboard_widget.dart';
import '../../core/widgets/tiles.dart';
import '../../models/notifications_model.dart';
import '../../models/store_list_model.dart';
import '../../models/store_model.dart';
import '../../models/store_notification_model.dart';
import '../../models/user_model.dart';
import '../agents/view/agents_screen.dart';
import '../agents/view/store_detail_screen.dart';
import '../notifications/notification_controller.dart';
import '../notifications/notifications_screen.dart';
import '../overview/admin_overview_screen.dart';
import '../warehouse_manager/views/all_manager.dart';
import '../warehouse_stock/screens/admin_warehouse_stock_1.dart';
import 'dashboard_screen.dart';

class DashboardController extends GetxController {
  String notificationSelectedTab = "pending";
  int selectedWidgetIndex = 0;
  Widget? selectedWidget;
  FirebaseFirestore firebasedb = FirebaseFirestore.instance;
  List<UserModel> totalAgents = <UserModel>[];
  String selectedAgent = "Select Agent";
  List<String> agentsList = ["Select Agent"];
  bool isOnAgentTap = false;
  FilePickerResult? filePickerResult;
  DateTime recentExcelFileTime = DateTime.now();
  List<String> storeNamesList = [];
  DateTime? firstDate;
  DateTime? secondDate;
  String? firstDateText;
  String? secondDateText;
  bool isNotification = false;
  int notificationIndex = 0;
  List<StoreNotificationModel> storeNotificationsList = [];
  List<StoreNotificationModel> unreadNotificationsList = [];
  List<String> unreadIdList = [];
  final List<GlobalKey> notificationKeys = [];

  void changeTab(String status) {
    notificationSelectedTab = status;
    update();
  }

  @override
  onInit() {
    super.onInit();
    selectedWidgetIndex = 0;
    awaitMethod();
  }

  awaitMethod() async {
    updateWidget();
    await getAllAgents();
  }

  getAllAgents() async {
    final db = await firebasedb
        .collection(Collection.users.name)
        .where("role", isEqualTo: Role.agent.name)
        .where("status", isEqualTo: UserStatus.approved.name)
        .orderBy("createdAt", descending: true)
        .get();
    totalAgents = db.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    for (var element in totalAgents) {
      agentsList.add("${element.firstName} ${element.lastName}");
      update();
    }
    update();
  }

  updateWidget() {
    switch (selectedWidgetIndex) {
      case 0:
        selectedWidget = const DashboardScreenWidget();
        break;
      case 1:
        selectedWidget = const AgentsScreenWidget();
        break;
      case 2:
        selectedWidget = const AdminOverviewScreen();
        break;
      case 3:
        selectedWidget = NotificationsScreen(
          notificationText: notificationSelectedTab,
        );
        break;
      case 4:
        selectedWidget = const WarehouseManagerScreen();
        break;
      case 5:
        selectedWidget = const AdminWarehouseStocksScreen1();
        break;
      default:
        selectedWidget = const DashboardScreenWidget();
    }
  }

  List<Widget> dashboards = [
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(Collection.users.name)
            .where("role", isEqualTo: Role.agent.name)
            .where("status", isEqualTo: UserStatus.approved.name)
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return AgentDashboardWidget(
            dashboardTitle: "Agents",
            dashboardDescription: "No. of Agents",
            quantity: "${snapshot.data?.docs.length ?? 0}",
            totalCostEnable: true,
          );
        }),
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(Collection.users.name)
            .where("role", isEqualTo: Role.manager.name)
            .where("status", isEqualTo: UserStatus.approved.name)
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return AgentDashboardWidget(
            dashboardTitle: "Managers",
            dashboardDescription: "No. of Managers",
            quantity: "${snapshot.data?.docs.length ?? 0}",
            totalCostEnable: false,
          );
        }),
  ];

  void logout(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("Log out"),
            content: const SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Are you sure you want to log out?"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: const Text(
                  "Log out",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  LoadingHelper.showLoading();
                  Get.back();
                  SignOutService().signOut();
                  LoadingHelper.hideLoading();
                  // Get.offAll(() => const LoginScreen());
                  Get.offAllNamed('/login');
                  Constant.user = null;
                },
              ),
            ]);
      },
    );
  }

  StreamBuilder notifications(String status) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: firebasedb
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
            final noti = notifications[index];
            return CustomListTileWidget(
              title: "${noti.firstName} ${noti.lastName} | ",
              role: "${noti.role.capitalize}",
              imgurl: noti.imgUrl,
              subtitle: noti.email,
              accpet: status != UserStatus.approved.name
                  ? () => NotificationController().accept(
                        UserData(
                          context: context,
                          notification: notifications[index],
                          status: status,
                          userEmail: noti.email,
                          userName: "${noti.firstName} ${noti.lastName}",
                        ),
                      )
                  : null,
              reject: status != UserStatus.decline.name
                  ? () => NotificationController().reject(
                        UserData(
                          context: context,
                          notification: notifications[index],
                          status: status,
                          userEmail: noti.email,
                          userName: "${noti.firstName} ${noti.lastName}",
                        ),
                      )
                  : null,
            );
          },
        );
      },
    );
  }

  // Excel File Picker Section
  filePickerMethod() async {
    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (filePickerResult == null) {
      return;
    }
    if (filePickerResult != null) {
      showingExcelFile(filePickerResult);
    }
  }

  // showing data from excel file at flutter app
  showingExcelFile(FilePickerResult? result) async {
    try {
      storeNamesList.clear();
      Uint8List bytes = result!.files.single.bytes!;
      Excel excel = Excel.decodeBytes(bytes);
      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table]!;
        for (int row = 0; row < sheet.maxRows; row++) {
          sheet.row(row).forEach((cell) {
            var val = cell!.value;
            storeNamesList.add("$val");
            update();
          });
        }
      }
      update();
      if (storeNamesList.length > 10) {
        storeNamesList.clear();
        update();
        showOkAlertDialog(
            context: Get.context!, message: "You Select 10 Stores Only");
      }
    } catch (error) {
      showOkAlertDialog(context: Get.context!, message: "Excel File Error");
    }
  }

  //Date Picker Section
  datePicker(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    update();
    if (date == null) return;
    return date;
  }

  // Select First date
  firstDateMethod(BuildContext context) async {
    firstDate = await datePicker(context);
    if (firstDate == null) return;
    firstDateText =
        DateFormat("dd-MM-yyyy").format(firstDate ?? DateTime.now());
    update();
  }

  // Select Second date
  secondDateMethod(BuildContext context) async {
    secondDate = await datePicker(context);
    if (secondDate == null) return;
    secondDateText =
        DateFormat("dd-MM-yyyy").format(secondDate ?? DateTime.now());
    update();
  }

  // Adaptive Dialog Method
  Future<dynamic> alertDialogMethod() {
    return showOkCancelAlertDialog(
      context: Get.context!,
      title: "Assign Stores",
      okLabel: "SAVE",
      cancelLabel: "CANCEl",
    );
  }

  //Firebase Uploading Section
  //alertdialog
  askSaveButtonDialog() async {
    if (selectedAgent == "Select Agent") {
      LoadingHelper.hideLoading();
      return showOkAlertDialog(
          context: Get.context!, message: "Please Select Agent Name");
    }

    if (storeNamesList.isEmpty) {
      LoadingHelper.hideLoading();
      return showOkAlertDialog(
          context: Get.context!, message: "Please Upload Stores List");
    }

    if (firstDate == null) {
      LoadingHelper.hideLoading();
      return showOkAlertDialog(
          context: Get.context!, message: "Please Select Assigning Date");
    }

    if (secondDate == null) {
      LoadingHelper.hideLoading();
      return showOkAlertDialog(
          context: Get.context!, message: "Please Select Due Date");
    }

    final result = await alertDialogMethod();
    if (result == OkCancelResult.ok) {
      await assignStoreMethod();
    }
  }

  // Uploading Excel File into Firebase
  assignStoreMethod() async {
    try {
      LoadingHelper.showLoading();

      // Initialize variables
      StoreListModel storeListModel = StoreListModel();
      List<String> dbStoresList = [];

      // Get Agent user data
      final result = totalAgents.firstWhere((element) =>
          "${element.firstName} ${element.lastName}" == selectedAgent);

      dbStoresList.addAll(storeNamesList);

      final db =
          await firebasedb.collection("allStoresList").doc(result.uid).get();
      storeListModel = StoreListModel.fromMap(db.data()!);
      // print("Data: $");
      dbStoresList.addAll(storeListModel.storesList ?? []);

      // Initialize values
      storeListModel.createdAt = Timestamp.now();
      storeListModel.agentName = selectedAgent;
      storeListModel.docId = result.uid;
      storeListModel.assigningDate = Timestamp.fromDate(firstDate!);
      storeListModel.endDate = Timestamp.fromDate(secondDate!);
      storeListModel.storesList = dbStoresList;

      // get recent uploading time
      recentExcelFileTime = DateTime.fromMillisecondsSinceEpoch(
          storeListModel.createdAt!.seconds * 1000);

      // firebase logic
      await firebasedb
          .collection("allStoresList")
          .doc(result.uid)
          .set(storeListModel.toMap())
          .then((result) {
        storeNamesList.clear();
        dbStoresList.clear();
        selectedAgent = "Select Agent";
        firstDateText = null;
        secondDateText = null;
        update();
        LoadingHelper.hideLoading();
        showOkAlertDialog(
            context: Get.context!,
            message: "Congratulations You have Assign stores to an Agent.");
      });

      //
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      showOkAlertDialog(
          context: Get.context!,
          message: e.message ?? "Something went wrong! Please try again later");
    }
  }

  // Notification Section
  storeNotificationMethod(StoreNotificationModel storeNotificationModel) async {
    // If Agent Decine store
    if (storeNotificationModel.isDecline == true) {
      Get.to(
        () => DeclineNotificationScreen(
            storeNotificationModel: storeNotificationModel),
        routeName: '/declinereason',
      );
      if (storeNotificationModel.notificationView == false) {
        await notificationViewMethod(storeNotificationModel);
      }
    }

    // If Agent Visit store
    if (storeNotificationModel.isDecline == false) {
      storeVisitMethod(storeNotificationModel);
      if (storeNotificationModel.notificationView == false) {
        await notificationViewMethod(storeNotificationModel);
      }
    }
  }

  // Change View variable from firebase
  notificationViewMethod(StoreNotificationModel storeNotificationModel) async {
    try {
      // Change bool value of notification view from the firebase
      storeNotificationModel.notificationView = true;
      await firebasedb
          .collection("storeNotification")
          .doc(storeNotificationModel.notificationId)
          .set(storeNotificationModel.toMap());
      update();

      // Delete Selected Notification from local Lists
      unreadNotificationsList.removeWhere(
          (element) => element.storeName == storeNotificationModel.storeName);
      unreadIdList.remove("${storeNotificationModel.notificationId}");
      update();
    } on FirebaseException catch (e) {
      showOkAlertDialog(
          context: Get.context!,
          message: e.message ?? "Something went wrong! Please try again later");
    }
  }

  // Agent Visit Store
  storeVisitMethod(StoreNotificationModel storeNotificationModel) async {
    LoadingHelper.showLoading();
    final db = await firebasedb
        .collection("storeData")
        .where("addById", isEqualTo: storeNotificationModel.agentID)
        .orderBy("createdAt")
        .get();
    List<StoreModel> allStoresList =
        db.docs.map((doc) => StoreModel.fromMap(doc.data())).toList();
    try {
      final result = allStoresList.firstWhere(
          (element) => element.storeName == storeNotificationModel.storeName);
      LoadingHelper.hideLoading();
      Get.to(
        () => StoreDetailScreen(store: result),
        routeName: '/storeinformation',
      );
    } catch (e) {
      LoadingHelper.hideLoading();
      showOkAlertDialog(
          context: Get.context!, message: "This store is not exist");
    }
  }

  // All Notification in single click
  clearAllNotifications(
      List<StoreNotificationModel> storeNotificationsModel) async {
    LoadingHelper.showLoading();
    for (var index = 0; index < storeNotificationsModel.length; index++) {
      final result = storeNotificationsModel.firstWhere((element) =>
          element.agentID == storeNotificationsModel[index].agentID);
      await firebasedb
          .collection("storeNotification")
          .doc(result.notificationId)
          .delete();
      update();
      LoadingHelper.hideLoading();
    }
  }

  // Delete a Notification
  clearNotification(StoreNotificationModel storeNotificationModel) async {
    LoadingHelper.showLoading();
    await firebasedb
        .collection("storeNotification")
        .doc(storeNotificationModel.notificationId)
        .delete();
    update();

    storeNotificationsList.removeWhere(
        (element) => element.storeName == storeNotificationModel.storeName);
    update();
    LoadingHelper.hideLoading();
  }
}
