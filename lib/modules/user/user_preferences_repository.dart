import 'package:holo_challenge/core/constants/local_storage_keys.dart';
import 'package:holo_challenge/modules/user/user_preferences_model.dart';
import 'package:holo_challenge/utils/shared_preferences_utils.dart';

class UserPreferencesRepository {
  static const _prefKey = LocalStorageKeys.userPreferences;

  static Future<UserPreferencesModel?> getUserPreferences() async {
    UserPreferencesModel? userPreferences;
    var result = await SharedPreferencesUtils.getObject(key: _prefKey);
    if (result != null) {
      userPreferences = UserPreferencesModel.fromJson(result);
    }
    return userPreferences;
  }

  static Future<bool?> saveUserPreferences(UserPreferencesModel list) async {
    return await SharedPreferencesUtils.saveObject(key: _prefKey, value: list);
  }
}
