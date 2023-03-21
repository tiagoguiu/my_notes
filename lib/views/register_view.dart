import 'package:flutter/material.dart';
import 'package:vandad_flutter_course/routes/routes.dart';
import 'package:vandad_flutter_course/services/auth/auth.dart';
import 'package:vandad_flutter_course/utils/utils.dart';

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
    return Scaffold(
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
            onPressed: () async {
              try {
                final email = emailController.text;
                final password = passwordController.text;
                await AuthService.firebase().createUser(
                  params: AuthProviderParams(email: email, password: password),
                );
                await AuthService.firebase().sendEmailVerification();
                if (context.mounted) {
                  Navigator.of(context).pushNamed(AppRoutes.verifyEmailRoute);
                }
              } on WeekPasswordAuthException {
                await showErrorDialog(context: context, text: 'Week password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context: context, text: 'Email already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context: context, text: 'Invalid email');
              } on GenericAuthException {
                await showErrorDialog(context: context, text: 'Something went wrong, try again');
              }
            },
          ),
          TextButton(
            child: const Text('Already registered? Login here!'),
            onPressed: () async {
              Navigator.of(context).pushNamed(AppRoutes.loginRoute);
            },
          ),
        ],
      ),
    );
  }
}
