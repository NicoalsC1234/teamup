import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamup/model/user.dart';
import 'package:teamup/repository/auth_repository.dart';

class AuthRepository extends AuthRepositoryBase {
  final _firebaseAuth = FirebaseAuth.instance;

  AuthUser? _userFromFirebase(User? user) =>
      user == null ? null : AuthUser(user.uid, user.email!);

  @override
  Stream<AuthUser?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);

  @override
  Future<AuthUser?> login(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<AuthUser?> register (
      String name, String email, String password, int age, String description) async {
        ReceivePort port = ReceivePort();
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    if (authResult.user != null) {
      final user = MyUser(age: age, description: description, email: email,  name: name,  id: authResult.user!.uid);
      final ref =
          FirebaseFirestore.instance.doc('user/${authResult.user!.uid}');
      final isolate = await Isolate.spawn<List<dynamic>>(userToFirebaseMap, [port.sendPort, user]);
      final firebaseUser = await port.first;
      isolate.kill(priority: Isolate.immediate);
      await ref.set(firebaseUser, SetOptions(merge: true));
    }

    return _userFromFirebase(authResult.user);
  }


  void userToFirebaseMap(List<dynamic> values) {
    SendPort sendPort = values[0];
    MyUser user = values[1];

    Map<String, dynamic> firebaseUser = user.toFirebaseMap();
    sendPort.send(firebaseUser);
  }
}
