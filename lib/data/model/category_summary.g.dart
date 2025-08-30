// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategorySummary _$CategorySummaryFromJson(Map<String, dynamic> json) =>
    _CategorySummary(
      category: json['category'] as String,
      icon: json['icon'] as String,
      percentage: (json['percentage'] as num).toDouble(),
      amount: (json['amount'] as num).toInt(),
      colorValue: (json['colorValue'] as num).toInt(),
    );

Map<String, dynamic> _$CategorySummaryToJson(_CategorySummary instance) =>
    <String, dynamic>{
      'category': instance.category,
      'icon': instance.icon,
      'percentage': instance.percentage,
      'amount': instance.amount,
      'colorValue': instance.colorValue,
    };
