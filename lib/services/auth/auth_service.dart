// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vandad_flutter_course/services/auth/auth.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService({
    required this.provider,
  });

  @override
  Future<AuthUser> createUser({required AuthProviderParams params}) =>
      provider.createUser(params: params);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({required AuthProviderParams params}) =>
      provider.logIn(params: params);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
