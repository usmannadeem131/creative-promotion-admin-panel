import 'dart:math';

import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/store_model.dart';
import '../../models/supply_stock_model.dart';

String getInitialCharacters(String name) => name.isNotEmpty
    ? name
        .trim()
        .split(RegExp(' +'))
        .map((s) => s[0])
        .take(2)
        .join()
        .toUpperCase()
    : '';

extension Formatter on dynamic {
  String formatter() => NumberFormat.compactCurrency(
        decimalDigits: 0,
        symbol: '',
      ).format(this);
}

String getRandomString(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => chars.codeUnitAt(
        rnd.nextInt(chars.length),
      ),
    ),
  );
}

launchPrivacyPolicyURL() async {
  final Uri url = Uri.parse('https://sapphiretechnologies.us/privacy-policy/');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

// Single Store Information Download Method-
void singleStoreDownload(StoreModel data) async {
  final excel = Excel.createExcel();
  final sheet1 = excel['Sheet1'];
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
      "Date";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
      "Store Name";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
      "Store Phone";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
      "Store Email";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
      "Designation";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
      "Store Address";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
      'Full Synthethic  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
      'Full Synthethic  - 5W-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
      'Full Synthethic  - 5W-30';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0)).value =
      'High Mileage  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0)).value =
      'High Mileage  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0)).value =
      'High Mileage  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0)).value =
      'Advance  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: 0)).value =
      'Advance  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: 0)).value =
      'Advance  - OW-20';
  DateTime formatedDate =
      DateTime.fromMillisecondsSinceEpoch(data.createdAt.seconds * 1000);
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value =
      DateFormat("dd/MM/yyyy - h:m a").format(formatedDate);
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1)).value =
      data.storeName;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 1)).value =
      data.storePhone;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 1)).value =
      data.storeEmail;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 1)).value =
      data.designation.designation;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 1)).value =
      data.storeAddress;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 1)).value =
      data.fullySyntyheticOW20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 1)).value =
      data.fullySyntyhetic5W20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 1)).value =
      data.fullySyntyhetic5W30;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 1)).value =
      data.highMileageOW20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 1)).value =
      data.highMileage5W20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 1)).value =
      data.highMileage5W30;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 1)).value =
      data.advanceOW20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: 1)).value =
      data.advance5W20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: 1)).value =
      data.advance5W30;
  excel.save();
}

// Single Supply Stock Download Method
void singleSupplyStockDownload(SupplyModel data) async {
  final excel = Excel.createExcel();
  final sheet1 = excel['Sheet1'];
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
      "Date";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
      "Warehouse Name";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
      "Agent Name";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
      "Email Address";
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
      'Full Synthethic  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
      'Full Synthethic  - 5W-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
      'Full Synthethic  - 5W-30';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
      'High Mileage  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
      'High Mileage  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0)).value =
      'High Mileage  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0)).value =
      'Advance  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0)).value =
      'Advance  - OW-20';
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0)).value =
      'Advance  - OW-20';

  DateTime formatedDate =
      DateTime.fromMillisecondsSinceEpoch(data.date.seconds * 1000);
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value =
      DateFormat("dd/MM/yyyy - h:m a").format(formatedDate);
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1)).value =
      data.warehouseName;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 1)).value =
      data.agentName;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 1)).value =
      data.emailAddress;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 1)).value =
      data.fullySyntyheticOW20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 1)).value =
      data.fullySyntyhetic5W20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 1)).value =
      data.fullySyntyhetic5W30;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 1)).value =
      data.highMileageOW20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 1)).value =
      data.highMileage5W20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 1)).value =
      data.highMileage5W30;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 1)).value =
      data.advanceOW20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 1)).value =
      data.advance5W20;
  sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 1)).value =
      data.advance5W30;
  excel.save();
}
