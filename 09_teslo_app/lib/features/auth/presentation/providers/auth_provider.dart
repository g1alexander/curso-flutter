import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/auth/domain/domain.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);

      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('no controlado');
    }
  }

  Future<void> registerUser(
      String email, String password, String fullName) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.register(email, password, fullName);

      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('no controlado');
    }
  }

  void checkStatus() async {}

  Future<void> logout(String? errorMessage) async {
    //TODO: clean token

    state = state.copyWith(
      user: null,
      status: AuthStatus.notAuthenticated,
      errorMessage: errorMessage,
    );
  }

  void _setLoggedUser(User user) {
    //TODO: save token in device

    state = state.copyWith(
      user: user,
      errorMessage: '',
      status: AuthStatus.authenticated,
    );
  }
}

enum AuthStatus { authenticated, notAuthenticated, checking }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String errorMessage;

  AuthState({
    this.status = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
