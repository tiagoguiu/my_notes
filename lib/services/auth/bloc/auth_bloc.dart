import 'package:bloc/bloc.dart';
import 'package:vandad_flutter_course/services/auth/auth.dart';
import 'package:vandad_flutter_course/services/auth/bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    on<AuthEventInitialize>(
      (event, emit) async {
        //HANDLING INITIALIZE EVENTS
        await provider.initialize();
        final user = provider.currentUser;
        if (user == null) {
          emit(const AuthStateLoggedOut(null));
        } else if (!user.isEmailVerified) {
          emit(const AuthStateNeedsVerification());
        } else {
          emit(AuthStateLoggedIn(user: user));
        }
      },
    );

    on<AuthEventLogIn>(
      (event, emit) async {
        final String email = event.email;
        final String password = event.password;
        try {
          final AuthUser user = await provider.logIn(params: AuthProviderParams(email: email, password: password));
          emit(AuthStateLoggedIn(user: user));
        } on Exception catch (e) {
          emit(
            AuthStateLoggedOut(e)
          );
        }
      },
    );

    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          emit(const AuthStateLoading());
          await provider.logOut();
          emit(const AuthStateLoggedOut(null));
        } on Exception catch (e) {
          emit(AuthStateLoggedOutFailure(exception: e));
        }
      },
    );
  }
}
