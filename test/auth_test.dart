import 'package:flutter_test/flutter_test.dart';
import 'package:vandad_flutter_course/services/auth/auth.dart';

void main() {
  group(
    'Mock Authentication',
    () {
      final sut = MockAuthProvider();

      test(
        'Should not be initialized to begin with',
        () {
          expect(sut.isInitialized, false);
        },
      );
      test(
        'Cannot log out if not initialized',
        () {
          expect(sut.logOut(),
              throwsA(const TypeMatcher<NotInitializedException>()));
        },
      );
      test(
        'Should be able to initialized',
        () async {
          await sut.initialize();
          expect(sut.isInitialized, true);
        },
      );
      test(
        'User should be null after initialization',
        () async {
          await sut.initialize();
          expect(sut.currentUser, null);
        },
      );
      test(
        'Should be able to initializa in less than 2 seconds',
        () async {
          await sut.initialize();
          expect(sut.isInitialized, true);
        },
        timeout: const Timeout(
          Duration(seconds: 2),
        ),
      );
      test(
        'Create user should delegate to logIn function',
        () async {
          final badEmailUser = sut.createUser(
            params: AuthProviderParams(
              email: 'foo@bar.com',
              password: 'anyPassword',
            ),
          );
          expect(badEmailUser,
              throwsA(const TypeMatcher<UserNotFoundAuthException>()));
          final badPasswordUser = sut.createUser(
            params: AuthProviderParams(
              email: 'anyEmail',
              password: 'foobar',
            ),
          );
          expect(badPasswordUser,
              throwsA(const TypeMatcher<WrongPasswordAuthException>()));

          final user = await sut.createUser(
            params: AuthProviderParams(
              email: 'foo',
              password: 'bar',
            ),
          );
          expect(sut.currentUser, user);
          expect(user.isEmailVerified, false);
        },
      );
      test(
        'Logged in user should be able to get verified ',
        () async {
          await sut.sendEmailVerification();
          final user = sut.currentUser;
          expect(user, isNotNull);
          expect(user!.isEmailVerified, true);
        },
      );
      test(
        'Should be able to log out and log in again ',
        () async {
          await sut.logOut();
          await sut.logIn(
            params: AuthProviderParams(
              email: 'foo',
              password: 'bar',
            ),
          );
          final user = sut.currentUser;
          expect(user, isNotNull);
        },
      );
    },
  );
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({required AuthProviderParams params}) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(params: params);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({required AuthProviderParams params}) async {
    if (!isInitialized) throw NotInitializedException();
    if (params.email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (params.password == 'foobar') throw WrongPasswordAuthException();
    var user = AuthUser(isEmailVerified: false, email: 'foo@bar.com');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    final newUser = AuthUser(isEmailVerified: true, email: 'foo@bar.com');
    _user = newUser;
  }
}
