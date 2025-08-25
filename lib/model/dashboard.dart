class DashboardData {
  final Summary summary;
  final WeeklyChart weeklyChart;

  DashboardData({required this.summary, required this.weeklyChart});

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      summary: Summary.fromJson(json['summary']),
      weeklyChart: WeeklyChart.fromJson(json['weekly_chart']),
    );
  }
}

class Summary {
  final int totalIncome;
  final int totalExpense;
  final int totalBalance;
  final int totalUsers;

  Summary({
    required this.totalIncome,
    required this.totalExpense,
    required this.totalBalance,
    required this.totalUsers,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalIncome: json['total_income'],
      totalExpense: json['total_expense'],
      totalBalance: json['total_balance'],
      totalUsers: json['total_users'],
    );
  }
}

class WeeklyChart {
  final String period;
  final List<ChartEntry> data;

  WeeklyChart({required this.period, required this.data});

  factory WeeklyChart.fromJson(Map<String, dynamic> json) {
    return WeeklyChart(
      period: json['period'],
      data: (json['data'] as List).map((e) => ChartEntry.fromJson(e)).toList(),
    );
  }
}

class ChartEntry {
  final String date;
  final int income;
  final int expense;
  final int balance;

  ChartEntry({
    required this.date,
    required this.income,
    required this.expense,
    required this.balance,
  });

  factory ChartEntry.fromJson(Map<String, dynamic> json) {
    return ChartEntry(
      date: json['date'],
      income: json['income'],
      expense: json['expense'],
      balance: json['balance'],
    );
  }
}

