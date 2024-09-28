import 'package:formz/formz.dart';

// Define input validation errors
enum FullnameError { empty, length, nameAndLastName }

// Extend FormzInput and provide the input type and error type.
class Fullname extends FormzInput<String, FullnameError> {
  // Call super.pure to represent an unmodified form input.
  const Fullname.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Fullname.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == FullnameError.empty) return 'EL campo es requerido';
    if (displayError == FullnameError.length) {
      return 'Minimo 6 caracteres';
    }
    if (displayError == FullnameError.nameAndLastName) {
      return 'Debe ingresar nombre y apellido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  FullnameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return FullnameError.empty;
    if (value.length < 6) return FullnameError.length;
    if (value.split(' ').length < 2) return FullnameError.nameAndLastName;

    return null;
  }
}
