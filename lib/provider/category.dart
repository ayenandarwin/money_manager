import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/data/model/category/category.dart';
import 'package:money_manager_app/provider/service_provider.dart';

final categoryProvider = FutureProvider.autoDispose<List<Category>>((
  ref,
) async {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return categoryRepository.getCategoryData();
});
