import 'package:bloc/bloc.dart';
import 'package:vandad_flutter_course/services/auth/auth.dart';
import 'package:vandad_flutter_course/services/auth/bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    on<AuthEventInitialize>(
      (event, emit) async {
        //HANDLING INITIALIZE EVENTS
        await provider.initialize();
        final user = provider.currentUser;
        if (user == null) {
          emit(const AuthStateLoggedOut(exception: null, isLoading: false));
        } else if (!user.isEmailVerified) {
          emit(const AuthStateNeedsVerification());
        } else {
          emit(AuthStateLoggedIn(user: user));
        }
      },
    );

    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      },
    );

    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(null));
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
          emit(const AuthStateNeedsVerification());
        } on Exception catch (e) {
          emit(AuthStateRegistering(e));
        }
      },
    );

    on<AuthEventLogIn>(
      (event, emit) async {
        emit(const AuthStateLoggedOut(isLoading: true));
        final String email = event.email;
        final String password = event.password;
        try {
          final AuthUser user = await provider.logIn(params: AuthProviderParams(email: email, password: password));
          if (!user.isEmailVerified) {
            emit(const AuthStateLoggedOut(isLoading: false));
            emit(const AuthStateNeedsVerification());
          } else {
            emit(const AuthStateLoggedOut(isLoading: false));
            emit(AuthStateLoggedIn(user: user));
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
