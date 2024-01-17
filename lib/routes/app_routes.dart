import 'package:get/get.dart';

import '../screens/agents/view/agent_data.dart';
import '../screens/agents/view/agents_detail_screen.dart';
import '../screens/dasboard/dashboard_screen.dart' as admin;
import '../screens/login/login_screen.dart';
import '../screens/profile/admin_profile_screen.dart';
import '../screens/warehouse_manager/views/supply_data.dart';
import '../screens/warehouse_manager/views/warehouse_manager_detail.dart';
import '../screens/warehouse_stock/screens/admin_warehouse_stock_2.dart';

class AppPages {
  static String initialroute = '/';
  static final List<GetPage> pages = [
    GetPage(
      name: '/login', // Set the initial route here
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: '/dasboard',
      page: () => const admin.DashboardScreen(),
    ),
    GetPage(
      name: '/profile',
      page: () => const AdminProfileScreen(),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut<AdminProfileController>(() => AdminProfileController());
      // }),
    ),
    GetPage(
      name: '/agentdetails',
      page: () => const AgentDetailScreen(),
    ),
    GetPage(
      name: '/agentdata',
      page: () => const AgentDataScreen(),
    ),
    GetPage(
      name: '/managerdetails',
      page: () => const WarehouseManagerDetail(),
    ),
    GetPage(
      name: '/supplystock',
      page: () => const SupplyData(),
    ),
    GetPage(
      name: '/warehousestock',
      page: () => const AdminWarehouseStockScreen2(),
    ),
  ];
}
