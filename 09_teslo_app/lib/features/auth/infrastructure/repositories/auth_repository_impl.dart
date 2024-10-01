import 'package:teslo_app/features/auth/domain/domain.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl([AuthDatasource? datasource])
      : _datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return _datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return _datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return _datasource.register(email, password, fullName);
  }
}
