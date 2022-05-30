import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vandad_flutter_course/routes/routes.dart';

import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter with your email'),
          ),
          TextField(
            controller: passwordController,
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
            decoration:
                const InputDecoration(hintText: 'Enter with your password'),
          ),
          TextButton(
            child: const Text('Login'),
            onPressed: () async {
              try {
                final email = emailController.text;
                final password = passwordController.text;
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.notesRoute,
                  (route) => false,
                );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.verifyEmailRoute,
                  (route) => false,
                );
                }
                
              } on FirebaseAuthException catch (e) {
                await showErrorDialog(context: context, text: e.code);
              } catch (error) {
                await showErrorDialog(context: context, text: error.toString());
              }
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not registered yet? register here!'),
          ),
        ],
      ),
    );
  }
}
