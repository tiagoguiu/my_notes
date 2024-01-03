import 'package:bloc/bloc.dart';

import '../auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>(
      (event, emit) async {
        //HANDLING INITIALIZE EVENTS
        await provider.initialize();
        final user = provider.currentUser;
        if (user == null) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        } else if (!user.isEmailVerified) {
          emit(const AuthStateNeedsVerification(isLoading: false));
        } else {
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      },
    );

    on<AuthEventForgotPassword>(
      (event, emit) async {
        emit(
          const AuthStateForgotPassword(
            isLoading: false,
            exception: null,
            hasSentEmail: false,
          ),
        );
        final email = event.email;
        if (email == null) {
          return;
        }
        emit(
          const AuthStateForgotPassword(
            isLoading: true,
            exception: null,
            hasSentEmail: false,
          ),
        );
        bool didSendEmail;
        Exception? exception;
        try {
          await provider.sendPasswordReset(toEmail: email);
          didSendEmail = true;
        } on Exception catch (e) {
          didSendEmail = false;
          exception = e;
        }
        emit(
          AuthStateForgotPassword(
            isLoading: false,
            exception: exception,
            hasSentEmail: didSendEmail,
          ),
        );
      },
    );

    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      },
    );

    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(exception: null, isLoading: false));
    });

    on<AuthEventRegister>(
      (event, emit) async {
        try {
          await provider.createUser(
            params: AuthProviderParams(
              email: event.email,
              password: event.password,
            ),
          );
          await provider.sendEmailVerification();
          emit(const AuthStateNeedsVerification(isLoading: false));
        } on Exception catch (e) {
          emit(AuthStateRegistering(exception: e, isLoading: false));
        }
      },
    );

    on<AuthEventLogIn>(
      (event, emit) async {
        emit(const AuthStateLoggedOut(
          isLoading: true,
          loadingText: 'Please wait while you log in',
        ));
        final String email = event.email;
        final String password = event.password;
        try {
          final AuthUser user = await provider.logIn(params: AuthProviderParams(email: email, password: password));
          if (!user.isEmailVerified) {
            emit(const AuthStateLoggedOut(isLoading: false));
            emit(const AuthStateNeedsVerification(isLoading: false));
          } else {
            emit(const AuthStateLoggedOut(isLoading: false));
            emit(AuthStateLoggedIn(user: user, isLoading: false));
          }
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(exception: e, isLoading: false));
        }
      },
    );

    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          await provider.logOut();
          emit(const AuthStateLoggedOut(isLoading: false));
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(exception: e, isLoading: false));
        }
      },
    );
  }
}
