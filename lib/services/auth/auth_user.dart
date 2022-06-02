// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart' show User;

class AuthUser {
  final bool isEmailVerified;

  AuthUser({
    required this.isEmailVerified,
  });

  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);
}
