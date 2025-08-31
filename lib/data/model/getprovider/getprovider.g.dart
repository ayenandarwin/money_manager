// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getprovider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetProvider _$GetProviderFromJson(Map<String, dynamic> json) => _GetProvider(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$GetProviderToJson(_GetProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
