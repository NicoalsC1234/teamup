import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teamup/model/user.dart';
import 'package:teamup/repository/user_repository.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepositoryBase _userRepository;

  File? _pickedImage;
  late MyUser _user;
  late List<MyUser> _users;

  UserCubit(this._userRepository) : super(UserLoadingState());

  void setImage(File? imageFile) {
    _pickedImage = imageFile;
    emit(UserReadyState(_user, _pickedImage));
  }

  Future<void> getUser() async {
    emit(UserLoadingState());
    _user =
        (await _userRepository.getMyUser()) ?? MyUser(age: 0, name: "", email: "", description: "", id:'');
    emit(UserReadyState(_user, _pickedImage));
  }

  Future<void> saveUser(
      String uid, String name, String email, int age, String description) async {
    _user = MyUser(age: age, description: description, email: email, name: name, id: uid);
    emit(UserReadyState(_user, _pickedImage, isSaving: true));

    await _userRepository.saveMyUser(_user, _pickedImage);
    emit(UserReadyState(_user, _pickedImage));
  }

  Future<void>? getUsers() async {
    
    _users = await _userRepository.getUsers();
    emit(UsersReadyState(_users));
  }
}