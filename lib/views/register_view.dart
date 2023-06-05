import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vandad_flutter_course/services/auth/auth.dart';
import 'package:vandad_flutter_course/utils/utils.dart';

import '../services/auth/bloc/bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

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
        if (state is AuthStateRegistering) {
          if (state.exception is WeekPasswordAuthException) {
            await showErrorDialog(context: context, text: 'Week password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context: context, text: 'Email already in use');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context: context, text: 'Invalid email');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context: context, text: 'Something went wrong, try again');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
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
              child: const Text('Register'),
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                context.read<AuthBloc>().add(
                      AuthEventRegister(
                        email: email,
                        password: password,
                      ),
                    );
              },
            ),
            TextButton(
              child: const Text('Already registered? Login here!'),
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}
