import 'package:freezed_annotation/freezed_annotation.dart';
part 'category_summary.freezed.dart';
part 'category_summary.g.dart';
// class CategorySummary {
//   final String category;
//   final IconData icon; // Category icon
//   final double percentage;
//   final int amount;
//   final Color color; // Color for the pie chart slice and legend

//   CategorySummary({
//     required this.category,
//     required this.icon,
//     required this.percentage,
//     required this.amount,
//     required this.color,
//   });
// }

@freezed
abstract class CategorySummary with _$CategorySummary {
  const factory CategorySummary({
    required String category,
    required String icon, // Changed to String to store icon name
    required double percentage,
    required int amount,
    required int colorValue, // Store color as int value
  }) = _CategorySummary;

  factory CategorySummary.fromJson(Map<String, Object?> json) =>
      _$CategorySummaryFromJson(json);
}