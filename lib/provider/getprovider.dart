import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager_app/data/model/getprovider/getprovider.dart';
import 'package:money_manager_app/provider/service_provider.dart';

final getProviderProvider = FutureProvider.autoDispose<List<GetProvider>>((
  ref,
) async {
  final getProviderRepository = ref.watch(getProviderRepositoryProvider);
  return getProviderRepository.getGetProviderData();
});
