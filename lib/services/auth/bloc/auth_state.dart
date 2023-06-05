import 'package:flutter/foundation.dart' show immutable;
import 'package:vandad_flutter_course/services/auth/auth.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user});
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  const AuthStateLoggedOut(this.exception);
}

class AuthStateLoggedOutFailure extends AuthState {
  final Exception exception;
  const AuthStateLoggedOutFailure({required this.exception});
}
