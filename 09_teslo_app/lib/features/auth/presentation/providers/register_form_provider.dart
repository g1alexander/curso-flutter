import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_app/features/shared/shared.dart';

//TODO: 3 consume notifier - statenotifierprovider

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

//TODO: 2 impl notifier

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  Future<void> Function(String, String, String) registerUserCallback;

  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

  onFullnameChange(String value) {
    final newFullname = Fullname.dirty(value);

    state = state.copyWith(
        fullname: newFullname,
        isValid: Formz.validate(
            [newFullname, state.email, state.password, state.repeatPassword]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);

    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate(
            [newEmail, state.password, state.fullname, state.repeatPassword]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate(
            [newPassword, state.email, state.fullname, state.repeatPassword]));
  }

  onRepeatPasswordChange(String value) {
    final newRepeatPassword = Password.dirty(value);

    state = state.copyWith(
        repeatPassword: newRepeatPassword,
        isValid: Formz.validate(
            [newRepeatPassword, state.email, state.fullname, state.password]));
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    await registerUserCallback(
      state.email.value,
      state.password.value,
      state.fullname.value,
    );
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final fullname = Fullname.dirty(state.fullname.value);
    final repeatPassword = Password.dirty(state.repeatPassword.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        fullname: fullname,
        repeatPassword: repeatPassword,
        isValid: Formz.validate([password, email, fullname, repeatPassword]));
  }
}

//TODO: 1 state provider

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Fullname fullname;
  final Email email;
  final Password password;
  final Password repeatPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.fullname = const Fullname.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repeatPassword = const Password.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Fullname? fullname,
    Email? email,
    Password? password,
    Password? repeatPassword,
  }) =>
      RegisterFormState(
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
        isValid: isValid ?? this.isValid,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
        password: password ?? this.password,
        repeatPassword: repeatPassword ?? this.repeatPassword,
      );

  bool get isSamePassword => password.value == repeatPassword.value;

  @override
  String toString() {
    return """
      RegisterFormState:
        isPosting: $isPosting
        isFormPosted: $isFormPosted
        isValid: $isValid
        fullname: $fullname
        email: $email
        password: $password
        repeatPassword: $repeatPassword
    """;
  }
}
