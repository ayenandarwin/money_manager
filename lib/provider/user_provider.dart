
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/provider/service_provider.dart';

final userDataProvider = FutureProvider.autoDispose((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  return await userRepository.fetchUserData();
});
