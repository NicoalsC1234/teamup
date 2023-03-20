import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamup/repository/auth_repository.dart';
import 'package:teamup/cubit/state_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryBase _authRepository;
  late StreamSubscription _authSubscription;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> init() async {
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
  }

  Future<void> reset() async => emit(AuthInitial());

  void _authStateChanged(AuthUser? user) =>
      user == null ? emit(AuthSignedOut()) : emit(AuthSignedIn(user));

  Future<void> registerUser(
      String name, String email, String password, int age, String description) async {
    _signIn(_authRepository.register(name, email, password, age, description,));
  }

  Future<void> logInUser(String email, String password) =>
      _signIn(_authRepository.login(email, password));

  Future<void> _signIn(Future<AuthUser?> auxUser) async {
    try {
      emit(AuthSigningIn());
      final user = await auxUser;
      if (user == null) {
        emit(AuthError("Unknown error, try again later"));
      } else {
        print("exitoso");
        print(user.email);
        emit(AuthSignedIn(user));
      }
    } catch (e) {
      String errorMessage = e.toString().split(']')[1];
      emit(AuthError(errorMessage.toString()));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthSignedOut());
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
