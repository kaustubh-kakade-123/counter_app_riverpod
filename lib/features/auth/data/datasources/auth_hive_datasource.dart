import 'package:hive/hive.dart';
import '../models/user_model.dart';

class AuthHiveDatasource {
  static const String userBoxName = 'users';

  Future<Box> _openBox() async {
    return await Hive.openBox(userBoxName);
  }

  Future<void> addUser(UserModel user) async {
    final box = await _openBox();
    await box.put(user.email, user.toJson());
  }

  Future<UserModel?> getUser(String email) async {
    final box = await _openBox();
    final data = box.get(email);
    if (data != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  Future<bool> userExists(String email) async {
    final box = await _openBox();
    return box.containsKey(email);
  }
}
