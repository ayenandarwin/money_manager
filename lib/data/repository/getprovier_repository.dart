import 'package:money_manager_app/data/model/getprovider/getprovider.dart';
import 'package:money_manager_app/service/remote/getprovider.dart';

class GetProviderRepository {
  final GetProviderService getProviderService;

  GetProviderRepository({required this.getProviderService});

  Future<List<GetProvider>> getGetProviderData() async {
    return await getProviderService.getGetProviderData();
  }
}
