import 'package:freezed_annotation/freezed_annotation.dart';
part 'getprovider.freezed.dart';
part 'getprovider.g.dart';

@freezed
abstract class GetProvider with _$GetProvider {
  const factory GetProvider({
    required int id,
    required String name,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GetProvider;

  factory GetProvider.fromJson(Map<String, dynamic> json) =>
      _$GetProviderFromJson(json);
}
