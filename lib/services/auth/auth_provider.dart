// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vandad_flutter_course/services/auth/auth.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;
  Future<AuthUser> logIn({required AuthProviderParams params});
  Future<AuthUser> createUser({required AuthProviderParams params});
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> initialize();
}

class AuthProviderParams {
  final String email;
  final String password;

  AuthProviderParams({
    required this.email,
    required this.password,
  });
}
