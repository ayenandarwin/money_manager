enum TransactionType { expense, income, transfer } // Added transfer type

class Transaction {
  final String id;
  final String category;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String? description; // Optional description

  Transaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.type,
    required this.date,
    this.description,
  });

  // Factory constructor to create a Transaction from a map (e.g., from Firestore)
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      category: map['category'] as String,
      amount: map['amount'] as double,
      type: TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
      ),
      date: DateTime.parse(
        map['date'] as String,
      ), // Store date as ISO 8601 string
      description: map['description'] as String?,
    );
  }

  // Convert Transaction to a map (e.g., for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'type': type.toString().split('.').last, // Store enum as string
      'date': date.toIso8601String(), // Store date as ISO 8601 string
      'description': description,
    };
  }
}

//new

enum TransactionTypes { income, expense }

class TransactionModel {
  final int id;
  final int amount;
  final String description;
  final DateTime createdAt;
  final String category;
  final TransactionType type;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.category,
    required this.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json, TransactionType type) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      category: json['category']['name'],
      type: type,
    );
  }
}
