import 'package:freezed_annotation/freezed_annotation.dart';
part 'income.freezed.dart';
part 'income.g.dart';

@freezed
abstract class Income with _$Income {
  const factory Income({
    required int id,
    required double amount,
    required int userId,
    required int providerId,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Income;

  factory Income.fromJson(Map<String, dynamic> json) =>
      _$IncomeFromJson(json);
}
