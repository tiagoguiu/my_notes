import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vandad_flutter_course/routes/routes.dart';
import 'package:vandad_flutter_course/views/views.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vandad Flutter Course',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.homeRoute,
      routes: {
        AppRoutes.homeRoute : (context) => const HomeView(),
        AppRoutes.loginRoute : (context) => const LoginView(),
        AppRoutes.registerRoute : (context) => const RegisterView(),
        AppRoutes.notesRoute : (context) => const NotesView(),
      },
    );
  }
}
