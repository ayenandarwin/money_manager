import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/data/model/income/income.dart';
import 'package:money_manager_app/provider/service_provider.dart';

final icomeDataProvider = FutureProvider<Income>((ref) async {
  final incomeDataRepository = ref.watch(incomeRepositoryProvider);
  return await incomeDataRepository.getIncomeData();
});

final postIncomeProvider = FutureProvider.family<Income, Income>((
  ref,
  income,
) async {
  final incomeDataRepository = ref.watch(incomeRepositoryProvider);
  return await incomeDataRepository.postIncomeData(income);
});

final updateIncomeDataProvider = FutureProvider.family<Income, int>((
  ref,
  id,
) async {
  final incomeDataRepository = ref.watch(incomeRepositoryProvider);

  return await incomeDataRepository.updateIncomeData(id);
});

final deleteIncomeDataProvider = FutureProvider.family<Income, int>((
  ref,
  id,
) async {
  final incomeDataRepository = ref.watch(incomeRepositoryProvider);
  return await incomeDataRepository.deleteIncomeData(id);
});

final detailIncomeDataProvider = FutureProvider.family<Income, int>((
  ref,
  id,
) async {
  final incomeDataRepository = ref.watch(incomeRepositoryProvider);
  return await incomeDataRepository.detailIncomeData(id);
});
