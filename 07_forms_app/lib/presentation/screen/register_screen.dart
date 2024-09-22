import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FlutterLogo(
              size: 100,
            ),
            _RegisterForm(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre usuario',
            prefixIcon: Icons.person,
            onChanged: (value) => username = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Mínimo 6 caracteres';
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Correo electrónico',
            prefixIcon: Icons.email,
            onChanged: (value) => email = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );
              if (!emailRegExp.hasMatch(value)) return 'Correo inválido';
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Contraseña',
            prefixIcon: Icons.lock,
            obscureText: true,
            onChanged: (value) => password = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Mínimo 6 caracteres';
              return null;
            },
          ),
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('username: $username');
                print('email: $email');
                print('password: $password');
              }
            },
            label: const Text("Crear usuario"),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
