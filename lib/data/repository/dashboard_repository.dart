import 'package:money_manager_app/model/dashboard.dart';
import 'package:money_manager_app/service/remote/dashboard.dart';

class DashboardRepository {
  final DashboardService dashboardService;
  DashboardRepository({required this.dashboardService});

  Future<DashboardData> fetchDashboardData() async {
    return await dashboardService.fetchDashboardData();
  }
}