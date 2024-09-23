import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/screen/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
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

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();

    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;

    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre usuario',
            prefixIcon: Icons.person,
            onChanged: registerCubit.usernameChanged,
            errorText: username.errorText,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Correo electrónico',
            prefixIcon: Icons.email,
            onChanged: registerCubit.emailChanged,
            errorText: email.errorText,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Contraseña',
            prefixIcon: Icons.lock,
            obscureText: true,
            onChanged: registerCubit.passwordChanged,
            errorText: password.errorText,
          ),
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            onPressed: registerCubit.onSubmit,
            label: const Text("Crear usuario"),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
