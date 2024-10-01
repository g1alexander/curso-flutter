import 'package:teslo_app/config/config.dart';
import 'package:teslo_app/features/auth/domain/domain.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await Api()
          .post('/auth/login', data: {'email': email, 'password': password});

      return UserMapper.userJsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            message: e.response?.data['message'] ?? 'credentials not valid');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(
          message: 'Connection failed',
        );
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    try {
      final response = await Api().post('/auth/register',
          data: {'email': email, 'password': password, 'fullName': fullName});

      return UserMapper.userJsonToEntity(response.data);
    } catch (e) {
      throw RegistrationFailed();
    }
  }
}
