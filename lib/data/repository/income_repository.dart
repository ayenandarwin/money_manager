import 'package:money_manager_app/data/model/income/income.dart';
import 'package:money_manager_app/service/remote/income.dart';

class IncomeRepository {
  final IncomeService incomeService;

  IncomeRepository({required this.incomeService});

  Future<Income> getIncomeData() async {
    return await incomeService.getIncomeData();
  }

  Future<Income> postIncomeData(Income income) async {
    return await incomeService.postIncomeData(income);
  }

  Future<Income> updateIncomeData(int id) async {
    return await incomeService.updateIncomeData(id);
  }

  Future<Income> deleteIncomeData(int id) async {
    return await incomeService.deleteIncomeData(id);
  }

  Future<Income> detailIncomeData(int id) async {
    return await incomeService.detailIncomeData(id);
  }
}
