// class Expense {
//   final int id;
//   final double amount;
//   final String description;
//   final DateTime createdAt;
//   final String category;

//   Expense({
//     required this.id,
//     required this.amount,
//     required this.description,
//     required this.createdAt,
//     required this.category,
//   });

//   factory Expense.fromJson(Map<String, dynamic> json) {
//     return Expense(
//       id: json['id'],
//       amount: json['amount'].toDouble(),
//       description: json['description'],
//       createdAt: DateTime.parse(json['createdAt']),
//       category: json['category']['name'],
//     );
//   }
// }
