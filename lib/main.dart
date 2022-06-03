import 'package:flutter/material.dart';
import 'package:vandad_flutter_course/routes/routes.dart';
import 'package:vandad_flutter_course/views/views.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
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
        AppRoutes.verifyEmailRoute : (context) => const VerifyEmailView(),
      },
    );
  }
}
