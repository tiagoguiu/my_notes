import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vandad_flutter_course/services/auth/auth.dart';

import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  CloseDialog? closeDialogHandle;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context: context, text: 'User not found');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context: context, text: 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context: context, text: 'Something went wrong, try again');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Enter with your email'),
            ),
            TextField(
              controller: passwordController,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Enter with your password'),
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                context.read<AuthBloc>().add(AuthEventLogIn(email: email, password: password));
              },
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventShouldRegister());
              },
              child: const Text('Not registered yet? register here!'),
            ),
          ],
        ),
      ),
    );
  }
}
