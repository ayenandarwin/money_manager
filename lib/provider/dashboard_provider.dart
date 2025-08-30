import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/model/dashboard.dart';
import 'package:money_manager_app/provider/service_provider.dart';

final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  final dashboardRepository = ref.watch(dashboardRepositoryProvider);
  return await dashboardRepository.fetchDashboardData();
});