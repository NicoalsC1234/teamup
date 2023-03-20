import 'dart:io';

import 'package:teamup/model/user.dart';

abstract class UserRepositoryBase {
  Future<MyUser?> getMyUser();

  Future<void> saveMyUser(MyUser user, File? image);

  Future<List<MyUser>> getUsers();
}
