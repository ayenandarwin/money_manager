// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Expense _$ExpenseFromJson(Map<String, dynamic> json) => _Expense(
  id: (json['id'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  userId: (json['userId'] as num).toInt(),
  providerId: (json['providerId'] as num).toInt(),
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ExpenseToJson(_Expense instance) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'userId': instance.userId,
  'providerId': instance.providerId,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
