import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/stocks_model.dart';

class AdminWarehouseStockController extends GetxController {
  String uid = '';
  String catagoryID = "";
  String typeID = "";

  void onTap(String value) {
    uid = value;
    update();
    // Get.to(() => const AdminWarehouseStockScreen2());
    Get.toNamed('/warehousestock');
  }

  void weeklyDownloadData(List<StockModel> data) async {
    final excel = Excel.createExcel();
    final sheet1 = excel['Sheet1'];
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        "Date";
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        "Category";
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        "Quantity";

    for (int row = 0; row < data.length; row++) {
      DateTime formatedDate = DateTime.fromMillisecondsSinceEpoch(
          data[row].createdAt!.seconds * 1000);
      sheet1
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
          .value = DateFormat("dd/MM/yyyy - h:m a").format(formatedDate);
      sheet1
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
          .value = data[row].catagory;
      sheet1
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
          .value = data[row].quantity;
    }

    excel.save();
  }
}
