// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart' show User;

class AuthUser {
  final String id;
  final bool isEmailVerified;
  final String email;

  AuthUser({
    required this.id,
    required this.isEmailVerified,
    required this.email,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        isEmailVerified: user.emailVerified,
        email: user.email!,
        id: user.uid,
      );
}
