import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/enums.dart';
import '../../../models/store_model.dart';
import '../../../models/user_model.dart';
import 'agent_controller.dart';

class AgentDeailsController extends GetxController {
  DateTime? firstDate;
  DateTime? secondDate;
  String? firstDateText;
  String? secondDateText;
  bool isFirstSelect = false;
  bool isSecondSelect = false;
  UserModel? agentModel;
  List<StoreModel> allStoresList = [];
  List<StoreModel> selectedStores = [];
  bool isFetchedData = false;

  @override
  onInit() {
    super.onInit();
    agentModel = Get.arguments["userModel"];
    awaitMethod();
  }

  awaitMethod() async {
    await firebaseFetchMethod();
  }

  //Get Store Data from Firebase
  firebaseFetchMethod() async {
    final db = await FirebaseFirestore.instance
        .collection(Collection.storeData.name)
        .where("addById", isEqualTo: agentModel!.uid)
        .orderBy("createdAt")
        .get();

    allStoresList =
        db.docs.map((doc) => StoreModel.fromMap(doc.data())).toList();
  }

  //Date Picker function
  datePicker(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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
    isFirstSelect = true;
    update();
  }

  // Select Second date
  secondDateMethod(BuildContext context) async {
    secondDate = await datePicker(context);
    if (secondDate == null) return;
    secondDateText =
        DateFormat("dd-MM-yyyy").format(secondDate ?? DateTime.now());
    isSecondSelect = true;
    update();
  }

  //On Search Click Function
  onSearchFunction() async {
    selectedStores.clear();
    isFetchedData = false;
    update();
    // Get.to(() => const AgentDataScreen());
    Get.toNamed('/agentdata');
    selectedStores = allStoresList.where((store) {
      return store.createdAt.toDate().isAfter(firstDate!) &&
              store.createdAt.toDate().isBefore(secondDate!) ||
          store.createdAt.toDate().isAtSameMomentAs(firstDate!) ||
          store.createdAt.toDate().isAtSameMomentAs(secondDate!);
    }).toList();
    await Future.delayed(const Duration(seconds: 1));
    isFetchedData = true;
    update();
  }

  // restricted user method
  restrictAgent(BuildContext context, String uid) {
    final controller = Get.put(AgentController());
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Restricted agent'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Do you really want to restrict this agent?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Restrict',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    controller.restrictAgent(uid);
                  },
                ),
              ]);
        });
  }

  // unrestricted user data
  unRestrictAgent(BuildContext context, String uid) {
    final controller = Get.put(AgentController());
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Unrestricted agent'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Do you really want to unrestrict this agent?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Unrestricted',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    controller.unRestrictAgent(uid);
                  },
                ),
              ]);
        });
  }
}
