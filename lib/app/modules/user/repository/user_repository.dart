import 'package:autoagent/app/modules/user/model/user_model.dart';
import 'package:autoagent/app/modules/user/provider/user_provider.dart';

class UserRepository {
  final UserProvider _provider = UserProvider();

  Future<void> addUser(UserModel user) async {
    await _provider.create(user);
  }

  Future<UserModel?> getUser(String id) async {
    return await _provider.get(id);
  }
}
