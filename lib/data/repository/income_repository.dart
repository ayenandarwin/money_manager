import 'package:money_manager_app/data/model/income.dart';
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

}