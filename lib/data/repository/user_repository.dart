import 'package:money_manager_app/model/user.dart';
import 'package:money_manager_app/service/remote/user.dart';

class UserRepository {
  final UserService userService;
  UserRepository({required this.userService});

  Future<UserModel> fetchUserData() async {
    return await userService.fetchUserData();
  }
}
