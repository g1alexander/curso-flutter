import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_app/features/shared/services/key_value_storage_service.dart';

class SharedPreferencesStorage extends KeyValueStorageService {
  Future<SharedPreferences> getInstance() async =>
      await SharedPreferences.getInstance();

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getInstance();

    switch (T) {
      case == int:
        return prefs.getInt(key) as T?;
      case == String:
        return prefs.getString(key) as T?;
      default:
        throw UnimplementedError(
          'GET not implemented for type ${T.runtimeType}',
        );
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getInstance();

    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getInstance();

    switch (T) {
      case == int:
        prefs.setInt(key, value as int);
        break;
      case == String:
        prefs.setString(key, value as String);
      default:
        throw UnimplementedError(
          'Set not implemented for type ${T.runtimeType}',
        );
    }
  }
}
