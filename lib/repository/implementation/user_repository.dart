import 'package:teamup/model/user.dart';
import 'package:teamup/provider/firebase_provider.dart';
import 'dart:io';

import 'package:teamup/repository/user_repository.dart';

class UserRepository extends UserRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<void> saveMyUser(MyUser user, File? image) =>
      provider.saveMyUser(user, image);

  @override
  Future<List<MyUser>> getUsers() => provider.getUsers();
}
