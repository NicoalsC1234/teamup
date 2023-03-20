import 'package:equatable/equatable.dart';

abstract class AuthRepositoryBase {
  Stream<AuthUser?> get onAuthStateChanged;

  Future<AuthUser?> login(String email, String password);

  Future<void> signOut();

  Future<AuthUser?> register(
      String name, String email, String password, int age, String description);
}

class AuthUser extends Equatable {
  final String uid;
  final String email;

  const AuthUser(this.uid, this.email);

  @override
  List<Object?> get props => [uid, email];
}
